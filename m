Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EECC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC5A206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC5A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53853 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7XB-0006by-Kb
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hs7Ik-0001M8-Ed
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hs7Ii-0007Hq-Ob
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:11:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hs7If-0007CE-VO; Mon, 29 Jul 2019 11:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 34830308FC23;
 Mon, 29 Jul 2019 15:10:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F311160856;
 Mon, 29 Jul 2019 15:10:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7598F1138619; Mon, 29 Jul 2019 17:10:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <28464409.aSG18riZGY@lindworm.usersys.redhat.com>
 <87ftmprtuj.fsf@dusky.pond.sub.org>
 <2550520.5yHEQrR4yj@lindworm.usersys.redhat.com>
Date: Mon, 29 Jul 2019 17:10:54 +0200
In-Reply-To: <2550520.5yHEQrR4yj@lindworm.usersys.redhat.com> (Pino Toscano's
 message of "Mon, 29 Jul 2019 13:21:34 +0200")
Message-ID: <87a7cwnaf5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 29 Jul 2019 15:10:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, rjones@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pino Toscano <ptoscano@redhat.com> writes:

> On Monday, 29 July 2019 12:57:40 CEST Markus Armbruster wrote:
>> Pino Toscano <ptoscano@redhat.com> writes:
>> 
>> > On Friday, 26 July 2019 16:24:34 CEST Eric Blake wrote:
>> >> On 7/26/19 9:09 AM, Pino Toscano wrote:
>> >> > Add a 'private-key' option which represents the path of a private key
>> >> > to use for authentication, and 'private-key-secret' as the name of an
>> >> > object with its passphrase.
>> >> > 
>> >> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>> >> 
>> >> > +++ b/qapi/block-core.json
>> >> > @@ -3226,6 +3226,11 @@
>> >> >  # @password-secret:     ID of a QCryptoSecret object providing a password
>> >> >  #                       for authentication (since 4.2)
>> >> >  #
>> >> > +# @private-key:         path to the private key (since 4.2)
>> >> > +#
>> >> > +# @private-key-secret:  ID of a QCryptoSecret object providing the passphrase
>> >> > +#                       for 'private-key' (since 4.2)
>> >> 
>> >> Is password-secret intended to be mutually-exclusive with
>> >> private-key/private-key-secret?
>> >
>> > My initial thought was to allow users to specify data for all the
>> > authentication methods possible.  Either ways (all of them, or a single
>> > one) are fine for me.
>> 
>> How does this work at the libssh level?  Can you configure multiple
>> authentication methods, and let negotiation pick the one to be used?
>
> The remote servers sends all the authentication methods supported, and
> the user of libssh can decide which one(s) to attempt.  See for example
> the small tutorial in the libssh documentation:
> http://api.libssh.org/stable/libssh_tutor_authentication.html

SSH server and client negotiate: the server offers methods, the client
tries offered methods it likes one after the other.

This means we want QMP to let us configure which methods we like, along
with whatever data is necessary to actually try them.

In short, we don't want mutually exclusive here.

Correct?

