Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D62C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB4D20674
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivUBqUo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB4D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixPpt-0000Ha-PW
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ixPWm-0002TO-KW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ixPWj-0003ds-Rm
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:11:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41453
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ixPWj-0003cx-N9
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580451097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/hKssfTqGpa/gYEZkWQcvYASWY+aM6BGvgO4+yT9jc=;
 b=ivUBqUo5t1mjBIGp7XkQMUTJN9+i2QMalDhV0+Dtc607RztkYBtnhZWSVqwirOtzVH+vhI
 L+uuAJS5+7Nj/zYgXt6ZrWzAn2LmhMF3XPnPkq52v7qgdNgzQsLm+JGULzptfImBg/79XB
 AI1ZwU/2F1gHoSzO5+gmwBDwYwJtv4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-gTBVkOXvMLOnZr4sCi7hwA-1; Fri, 31 Jan 2020 01:11:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8750318B9FC1;
 Fri, 31 Jan 2020 06:11:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EA3819488;
 Fri, 31 Jan 2020 06:11:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32DE21138404; Fri, 31 Jan 2020 07:11:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
Date: Fri, 31 Jan 2020 07:11:15 +0100
In-Reply-To: <20200130210902.GA25927@paraplu> (Kashyap Chamarthy's message of
 "Thu, 30 Jan 2020 22:09:02 +0100")
Message-ID: <87y2toi29o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gTBVkOXvMLOnZr4sCi7hwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kashyap Chamarthy <kchamart@redhat.com> writes:

> On Wed, Jan 15, 2020 at 03:02:48PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> [Changed the subject-line to indicate deviation from the original
> topic.]
>
> [...]
>
>> > Libvirt is of course happy to switch to something else instead of
>> > qom-set for these features if QEMU wants to provide a safer
>> > alternative.
>>=20
>> Noted.
>>=20
>> libvirt's use of qom-set is okay.  What's not okay is the near-complete
>> lack of QOM documentation, its poor QMP interface, in part due to
>> non-integration with QAPI, and last but not least the lack of QOM
>> leadership leaving it adrift.
>
> What can be done to improve QOM documentation (or lack thereof)?

Are you trying to push us from idle grousing to actually improve things?
No fair!

> From a couple of hurried `grep` queries in the QEMU tree, there seems to
> be no explicit qom.rst|txt, or qemu-object-model.txt|rst or some such.
> (I hope I haven't missed any other files.)

As far as I know, all we have is the lovingly[*] written comments in
include/qom/object.h.  Sadly, we've let them rot in places.  In
particular, many newer functions are undocumented.

This is *reference* documentation.  What we lack (sorely!) is an
overview / friendly introduction, and a design document with rationale.
Reconstructing rationale now would involve guesswork.

> Let's dig further.  Ah, I come across this helpful 2016 blog post[1]
> ("An incomplete list of QEMU APIs") by Eduardo from my bookmarks.  Here
> I get some clues:
>
> (a) In the section titled "QOM", Eduardo writes:
>
>         "QOM is short for QEMU Object Model and was introduced in 2011.
>         It is heavily documented on its header file
>         [include/qom/object.h]"=20
>
>     Opening qom/object.h[2], indeed there is copious amounts of docs,
>     expressed as commented-out text.  Two questions:
>
>     - How much of this is still accurate?  (Sorry, if that's a loaded
>       question.)

May I present you Armbru's Comment Trust Levels:

ACTL2: The comment may be overly terse or incomplete, but the
probability for it to be outright wrong is low.

ACTL1: Treat as helpful guidance (with gratitude), but trust only the
code.

ACTL0: It is a tale Told by an idiot[**], full of sound and fury,
Signifying nothing.

Most comments in decently maintained code are at ACTL1.

Around the time initial QOM development solidified, object.h's comments
were ACTL2.  The neglect that is now clearly visible there makes me
downgrade to ACTL1.

Paolo will have a more informed and possibly different opinion.

>     - If at least 60% is still accurate, is it valuable to extract and
>       publish it as rendered rST, as part of the on-going QEMU Docs
>       improvement?

Beware, personal opinion.

When you put documentation next to the code it documents (which you
absolutely should, because it's your only realistic chance to keep the
two in sync), then extracting API comments is useful, because it
collects them in one place.

It's of next to no use to me when the comments are all in the same place
already, namely the header.

> (b) The other clue is also from the same post, where Eduardo provides
>     pointers to past KVM Forum presentations by MarkusA, PaoloB,
>     AndreasF on QOM, Qdev et al.
>
>     Is it worth slapping all these references (with a clear intro and
>     outro) into a qom.rst file in QEMU tree, even if only for
>     reference/context?  Or are these references, in-tree docs in
>     object.h out-of-date beyond repair? =20

Uff.

My qdev talks predate the rebase onto QOM.  They may well confuse /
mislead as much as inform now.

> If it is useful, I'm happy to get the initial doc going, secure in the
> knowledge that more clueful people than me will chip in during the
> review :-)

Ha, nerd sniping!

> [1] https://habkost.net/posts/2016/11/incomplete-list-of-qemu-apis.html
> [2] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dinclude/qom/object.h
> [3] http://www.linux-kvm.org/images/9/90/Kvmforum14-qom.pdf


[*] Absolutely no irony intended.  Honest, officer!

[**] Don't take it personally, we're all part-time idiots.  Besides,
this is literature.


