Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3D8C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C632082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C632082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRLW2-0002FU-Jb
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 14:54:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hRLVG-0001yY-1g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hRLVE-0003Dm-RB
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:53:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hRLVE-0003Dh-LR
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:53:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so458215wmg.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 11:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=3I+Y9I92fsgDWCWS7AR8dC3ymolrFORHrYiZcYZWMus=;
	b=KnPzVVabMlsNpF2mlUw8Nc4FiYRFzkb1pI8SLGW4FViGg+4/9/wpfqVStpuQkzNJcY
	Tvo+A8OWaWEYRWRraJYw38wrkCOU1HWJyL/74S7owSKPwyYR07WV5o//GtsHUNqZVoBq
	qmGaqO3x4CKgo6utTWYoGjc1bgaScD3fDbCnLikEO1o6MKjRB+hDF6x0a5wx+O34JiBX
	ZTuxGc+GZli9HViiA59JQjonxKYHyFxSR/2Imup/O9BgiXc7HosTAdRpYl1Q6s4CcKz4
	EitxaSTfFLSrzJDKRLEombm11TTLkURa04c7ozeElbYZ9PlGgNToBoQXpxvasnSFRSG2
	GiiA==
X-Gm-Message-State: APjAAAVzw5D7WAzdCdFZhzNq5jI1hk/pZW5eRXED2gzM0C/bvCYYd+TP
	za+c54ZjvbbqWM+g5EGeNyvZIoSoIcqO67oP2spc/w==
X-Google-Smtp-Source: APXvYqwtx92V6DWUKbdm7JlNJFfvP9PwlRqaOzsfNbFB5DWL7UQlcv+Vvlpbs2rh/kSigt9lhRWhMlcZ3k1lL8ogUHU=
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr30142908wme.72.1558032795359;
	Thu, 16 May 2019 11:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
In-Reply-To: <6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 16 May 2019 20:53:04 +0200
Message-ID: <CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 8:33 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 5/16/19 6:04 PM, Peter Maydell wrote:
> > On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >>
> >> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0=
ccae8:
> >>
> >>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reque=
st' into staging (2019-05-10 14:49:36 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >>
> >> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd7=
3:
> >>
> >>   tests: acpi: print error unable to dump ACPI table during rebuild (2=
019-05-14 21:19:14 -0400)
> >>
> >> ----------------------------------------------------------------
> >> pci, pc, virtio: features, fixes
> >>
> >> reconnect for vhost blk
> >> tests for UEFI
> >> misc other stuff
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> >> ----------------------------------------------------------------
> >
> > Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
> > because the conversion of arm to Kconfig has landed in master.
> > Could you rebase and fix up to use whatever the Kconfig
> > equivalent of these changes is, please?
>
> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
>
> The conflict doesn't look trivial to resolve (to me) so I'd rather see
> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(

Thomas, FYI I did this to resolve the conflict:

- keep default-configs/arm-softmmu.mak from master:

  git checkout origin/master default-configs/arm-softmmu.mak

- applied the following !fixup snippet:

-- >8 --
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -25,7 +25,7 @@ config ACPI_NVDIMM

 config ACPI_PCI
     bool
-    depends on ACPI
+    depends on ACPI && PCI

---

I felt it easier to review on top of "hw/acpi: Improve build modularity"
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04718.html

Sadly both series clash :(

Regards,

Phil.

