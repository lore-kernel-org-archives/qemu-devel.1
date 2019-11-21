Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3034C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E40C20679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cg80WpX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E40C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmxJ-0000x1-LU
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iXmwT-0008VP-D8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iXmwR-00082b-HS
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:56:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iXmwR-00081z-DB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574344574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNEpFiZTRDZ3de2AJRuG/w24leyO5qJK3MCRJcPs/Zs=;
 b=Cg80WpX5Fg2zxsQH/O8uVWMNmdt5fXw3PcN5iqWFHQfC4QtWX04BUyQu6fZCoaI7j37+iP
 7XFF17dypo0lWc6n/hp01n7V+qaUOp7Mt0/keiuoaIJFJy0h8Dy88VuoeJ5GlvDytLt2he
 iTHce5oTPpuLXGyx0dXBN+cg+S9eYM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-EnNKFjyYOEekaMvXLdQRtQ-1; Thu, 21 Nov 2019 08:56:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21EE0800A02
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 13:56:12 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA5B31001925;
 Thu, 21 Nov 2019 13:56:11 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 379133E0527; Thu, 21 Nov 2019 14:56:09 +0100 (CET)
Date: Thu, 21 Nov 2019 14:56:09 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] Add a blog post about the QEMU-related
 presentation of KVM Forum 2019
Message-ID: <20191121135609.GB13912@paraplu>
References: <20191121115207.5832-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191121115207.5832-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: EnNKFjyYOEekaMvXLdQRtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 12:52:07PM +0100, Thomas Huth wrote:
> There have been quite a lot of QEMU-related talks at KVM Forum this
> year - let's provide a summary for the people who could not attend.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: For some talks it's hard to decide whether they really fit the
>  QEMU blog or not. I've assembled the list below by quickly skimming
>  through the schedule and the videos, and that's what I came up with ...
>  If you think any of the other talks should be mentioned here, too,
>  please let me know.

Do you also want to link to the LWN's summary, written by QEMU/KVM
contributors?  (It has at least 20 mentions of the word "QEMU"):

    https://lwn.net/Articles/805097/
    -- A recap of KVM Forum 2019

Other than that, looks good; FWIW:

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

>  _posts/2019-11-21-kvm-forum.md | 45 ++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 _posts/2019-11-21-kvm-forum.md
>=20
> diff --git a/_posts/2019-11-21-kvm-forum.md b/_posts/2019-11-21-kvm-forum=
.md
> new file mode 100644
> index 0000000..e5adf5d
> --- /dev/null
> +++ b/_posts/2019-11-21-kvm-forum.md
> @@ -0,0 +1,45 @@
> +---
> +layout: post
> +title:  "Presentations from KVM Forum 2019"
> +date:   2019-11-21 12:30:00 +0100
> +author: Thomas Huth
> +categories: [presentations, conferences]
> +---
> +Last month, the
> +[KVM Forum 2019](https://events.linuxfoundation.org/events/kvm-forum-201=
9/)
> +took place in Lyon, France. The conference also featured quite a lot tal=
ks
> +about QEMU, and now the videos of the presentation are available online.
> +So for those who could not attend, here is the list of the QEMU-related
> +presentations:
> +
> +* [QEMU Status Report](https://www.youtube.com/watch?v=3D6_1QQaXPjd4)
> +  by Paolo Bonzini
> +
> +* [The Hype Around the RISC-V
> +  Hypervisor](https://www.youtube.com/watch?v=3D2MUka4lKGFU) by Alistair=
 Francis
> +  and Anup Patel
> +
> +* [Reworking the Inter-VM Shared Memory
> +  Device](https://www.youtube.com/watch?v=3DTiZrngLUFMA) by Jan Kiszka
> +
> +* [What's Going On? Taking Advantage of TCG's Total System
> +  Awareness](https://www.youtube.com/watch?v=3DwxIF0dvGDuM) by Alex Benn=
=E9e
> +
> +* [Towards the Higher Level Debugging with
> +  QEMU](https://www.youtube.com/watch?v=3DE2yJL82gJYM) by Pavel Dovgalyu=
k
> +
> +* [QEMU-Hexagon: Automatic Translation of the ISA Manual Pseudcode to Ti=
ny Code
> +  Instructions of a VLIW Architecture](https://www.youtube.com/watch?v=
=3D3EpnTYBOXCI)
> +  by Niccol=F2 Izzo and Taylor Simpson
> +
> +* [Reports of my Bloat Have Been Greatly
> +  Exaggerated](https://www.youtube.com/watch?v=3D5TY7m1AneRY) by Paolo B=
onzini
> +
> +* [Multi-process QEMU - Status Update](https://www.youtube.com/watch?v=
=3DlslVYCuk4CQ)
> +  by John Johnson and Elena Ufimtseva
> +
> +* [Bring QEMU to Micro Service World](https://www.youtube.com/watch?v=3D=
5hIDwkpXUiw)
> +  by Xiao Guangrong and Zhang Yulei
> +
> +More interesting virtualization-related talks can be found in the
> +[KVM Forum Youtube Channel](https://www.youtube.com/channel/UCRCSQmAOh7y=
zgheq-emy1xA).
> --=20
> 2.23.0
>=20
>=20

--=20
/kashyap


