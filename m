Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979E4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CDA214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW6lZRrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CDA214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSEy-00031G-JP
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iUSEL-0002XI-DO
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iUSEK-0004Ag-58
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:12:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56748
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iUSEK-0004AH-1q
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573549975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAHDriL9+0K2QaszthS1D7H3s/wHnNNqn04kCo7xOSM=;
 b=bW6lZRrhj2enJsyydbrVbUXxMpfAvKJMDqdyAB5jZcsDXOyIYkJHtyclN0N16NOF0Mw3qE
 5EapMZh5yPGEIQGo6fC/Il2s511x+LCf9g8WM8aivsYyeYW2wXNj2++ZC2hMzZpMzDx1fv
 sNqqvjGJbvcJNvipS1zumz3dipZPeTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-K8ZwaHA8N66f0G_kTiAGXg-1; Tue, 12 Nov 2019 04:12:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89B38017E0;
 Tue, 12 Nov 2019 09:12:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-43.ams2.redhat.com [10.36.117.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E798760872;
 Tue, 12 Nov 2019 09:12:46 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:12:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: API definition for LUKS key management
Message-ID: <20191112091245.GB5364@linux.fritz.box>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191111183424.GR814211@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111183424.GR814211@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: K8ZwaHA8N66f0G_kTiAGXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Ferlan <jferlan@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.11.2019 um 19:34 hat Daniel P. Berrang=E9 geschrieben:
> On Mon, Nov 11, 2019 at 05:58:20PM +0200, Maxim Levitsky wrote:
> > One of the concerns that was raised during the review was that amend in=
terface for luks that I propose is
> > different from the amend inteface used currently for qcow2.
> >=20
> > qcow2 amend interface specifies all the format options, thus overwrites=
 the existing options.
> > Thus it seems natural to make the luks amend interface work the same wa=
y, that it receive an array
> > of 8 slots, and for each slot specify if it is active, and if true what=
 password to put in it.
> > This does allow to add and erase the keyslots, but it doesn't allow:
> >=20
> >    * add a password without knowing all other passwords that exist in e=
xisting keyslots
> >      this can be mitigated by specifying which keyslots to modify for e=
xample by omitting the
> >      keyslots that shouldn't be touched from the array (passing null pl=
aceholder instead)
> >      but then it already doesn't follow the 'specify all the options ea=
ch time' principle.
>=20
> I think this is highly undesirable, as we must not assume that the
> mgmt app has access to all the passwords currently set.

And I think this shows the problem that we realy have with the crypto
driver and amend: For every other driver, if you must, you can query the
current settings and just write them back.

The difference here is that crypto doesn't allow to directly query or
specify the content of some options (the keyslots), but provides only a
way to derives that content from a secret, and obviously there is no way
back from the stored data to the secret (that's what it's for).

I think we have two options here:

1. Add a special "don't touch this" value for keyslots. Normally, just
   leaving out the value would be suitable syntax for this. Here,
   however, we have a list of keyslots, so we can't leave anything out.

   We could use something like an alternate between str (new secret ID),
   null (erase keyslot) and empty dict (leave it alone) - the latter
   feels a bit hackish, but maybe it's not too bad. If the list is
   shorter than 8 entries, the rest is assumed to mean "leave it alone",
   too.

2. Allow to query and set the raw key, which doesn't require a password

> The two key use cases for having multiple key slots are
>=20
>   - To enable a two-phase change of passwords to ensure new password
>     is safely written out before erasing the old password
>    =20
>   - To allow for multiple access passwords with different controls
>     or access to when each password is made available.
>=20
>     eg each VM may have a separate "backup password" securely
>     stored off host that is only made available for use when
>     doing disaster recovery.
>=20
> the second use case is doomed if you need to always provide all
> current passwords when changing any key slots.

That providing all current passwords doesn't work is obvious.

> >    * erase all keyslots matching a password - this is really hard to do=
 using this approach,
> >      unless we give user some kind of api to try each keyslot with give=
n password,
> >      which is kind of ugly and might be racy as well.
>=20
> > So what do you think?
>=20
> The point of using "amend" is that we already have some of the boilerplat=
e
> supporting framework around that, so it saves effort for both QEMU and
> our users. If the semantics of "amend" don't fit nicely though, then the
> benefit of re-using "amend" is cancelled out and we should go back to
> considering a separate "key-manage" command.

This wouldn't solve the fundamental problem that the crypto block
driver, as it currently is, isn't able to provide a blockdev-amend
callback. It's worse for qcow2 because qcow2 already implements amend.

I think we need to find a solution for the amend API.

Kevin


