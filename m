Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40940C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7162217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7162217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5Co-0008Dv-Uz
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:27:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH5BL-0007Fq-6a
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH5BK-0007Kv-0W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hH5BJ-0007KN-Ou
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:26:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E840C3008CCE;
	Thu, 18 Apr 2019 11:26:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6729C5D9C5;
	Thu, 18 Apr 2019 11:26:14 +0000 (UTC)
Date: Thu, 18 Apr 2019 12:26:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Message-ID: <20190418112610.GO13773@redhat.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 18 Apr 2019 11:26:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, armbru@redhat.com, dgilbert@redhat.com,
	qemu-devel@nongnu.org, imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418112610.nRRwljAHCSMLZe7NUUIT2CxUMpdkHBzzSTrw1gz2jew@z>

On Thu, Apr 18, 2019 at 11:28:41AM +0200, Andrew Jones wrote:
> Hi all,
> 
> First some background:
> 
> For the userspace side of AArch64 guest SVE support we need to
> expose KVM's allowed vector lengths bitmap to the user and allow
> the user to choose a subset of that bitmap. Since bitmaps are a
> bit awkward to work with then we'll likely want to expose it as
> an array of vector lengths instead. Also, assuming we want to
> expose the lengths as number-of-quadwords (quadword == 128 bits
> for AArch64 and vector lengths must be multiples of quadwords)
> rather than number-of-bits, then an example array (which will
> always be a sequence) might be
> 
>  [ 8, 16, 32 ]
> 
> The user may choose a subsequence, but only through truncation,
> i.e. [ 8, 32 ] is not valid, but [ 8, 16 ] is.
> 
> Furthermore, different hosts may support different sequences
> which have the same maximum. For example, if the above sequence
> is for Host_A, then Host_B could be
> 
>  [ 8, 16, 24, 32 ]
> 
> The host must support all lengths in the sequence, which means
> that while Host_A supports 32, since it doesn't support 24 and
> we can only truncate sequences, we must use either [ 8 ] or
> [ 8, 16 ] for a compatible sequence if we intend to migrate
> between the hosts.
> 
> Now to the $SUBJECT question:
> 
> My feeling is that we should require the sequence to be
> provided on the command line as a cpu property. Something
> like
> 
>   -cpu host,sve-vl-list=8:16
> 
> (I chose ':' for the delimiter because ',' can't work, but
> if there's a better choice, then that's fine by me.)
> 
> Afaict a property list like this will require a new parser,
> which feels a bit funny since it seems we should already
> have support for this type of thing somewhere in QEMU. So,
> the question is: do we? I see we have array properties, but
> I don't believe that works with the command line. Should we
> only use QMP for this? We already want some QMP in order to
> query the supported vector lengths. Maybe we should use QMP
> to set the selection too? But then what about command line
> support for developers? And if the property is on the command
> line then we don't have to add it to the migration stream.

You should be able to use arrays from the CLI with QemuOpts by repeating
the same option name many times, though I can't say it is a very
nice approach if you have many values to list as it gets very repetative.
That's the curse of not having a good CLI syntax for non-scalar data in
QemuOpts & why Markus believes we should switch to JSON for the CLI too

     -cpu host,sve-vl=8,sve-vl=16


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

