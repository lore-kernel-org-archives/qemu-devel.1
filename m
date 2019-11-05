Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF958C1747C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C445121882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C445121882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRzUN-0007Zq-1m
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRzTh-00071u-OJ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRzTf-0005F2-SL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:06:37 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:38755)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iRzTf-0005EG-I5; Tue, 05 Nov 2019 09:06:35 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MNKyQ-1iHdbE3CcE-00Onrv; Tue, 05 Nov 2019 15:06:26 +0100
Subject: Re: [PATCH] global: Squash 'the the'
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru
References: <20191104185202.102504-1-dgilbert@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d03117ee-7cb7-217b-972d-3e6fb0654f1b@vivier.eu>
Date: Tue, 5 Nov 2019 15:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104185202.102504-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hsU987FGRUYJixC/dZhAlz5Zc3hp94Z2xG2DivVAbcj2ilGGaGY
 ZtDM0Xy+qCABSb1dmWVb2sPnzpQHkvD/7FxH/rc1Om5DcDrWV9EOyAhdS/r0r+9g3Ok3Dzq
 35gv+xBZVpfeMiPy9NuC4ZYQ75IRiu+ZHxBmj+Gq0+E7EM+r58AYyPrxacw7hBKh0yCp+FB
 tqzVqefzxwJLwN34ZeNOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q6vR3iUbiBQ=:WUpXs4wroD4V3dhQeLIrBS
 KcEtj4l94N5wHN0MWArVcC0gzwzBIpvKsoOrZgWRwDQSo0rvqffmPOUk4cM5OcU8MWZPUX97z
 U04izkBvQuTe6MhWa1n1Umk16l5dhwY3zNsA87P9Y7oAAxwzi1SH7G7NpKfpM6C+mEnAEyNGN
 A0b/tOv/PfZ5vDwM5BJP68+f/hISVODN6ee/xQOh/djCmqyey5ho482WkXoYBNgHM49Q4r2Mw
 FpQ5S0edmcSoUK2rEt1Qs/QHPvkmmS2/Nfe4pImx7vz/Dbhu+3VFSqKLs4kV4AUx85nfBrLZV
 gk/7obkJRCCwhOn9ubvkAeK1AZeN9/wt4tDmk8npICZ6Bn+ihogyOz9OdtmwA6hA1HfBbQMUU
 bd7RAzcQT1LcH4dV0RT+FGVPihpjGwFJH1AKo3S+kauZFLMHM8bjMy8SE2lkHEXXTKnGrvy7n
 op1reBWuiWrKdm2WvA69JREeZBrgO5VQDIU1haV7rxAB9jjp64Hanqaa0WIz6C6KMGpcETPxL
 99RdY8WZ9C1ngqnUBOjzyYuP0KXpPSEG/QoovrZuGuhx1dFAzePK0lpSSV+gPklYglT763ZXw
 2xO4DXPIS/6h+6Qo3hSLxqiIfpWEwkPMBMXt3VXq5Cw1l7tdm8+4nvtc2quiZ9Qr9DU312+9i
 qxMzMOns1VeldKi2NRnbYNgs6o1o23iM3wVoKtDULiLgn6ovW9Ywn8wjv0IuAxNc6zfIB3Ek2
 LhqyGy8B12dwlfx95D0HxElnU326TBLW2a/jjhFxySHcZ0LDn0zj5LxHzlDq0P6bLqaC0V6/c
 jSulyLkWNWhHzNIbMNCVVOLS/oX/VXzfBIIsMKkiP87hTWfg6rXKJtd2boxegp04MEa4dgGEP
 AWvloUsaFL/8n43hqv6jD0DHpnm4a0ZtjWCmXzvfU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org,
 david@gibson.dropbear.id.au, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/11/2019 à 19:52, Dr. David Alan Gilbert (git) a écrit :
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> 'the' has a tendency to double up; squash them back down.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  disas/libvixl/vixl/invalset.h       | 2 +-
>  docs/interop/pr-helper.rst          | 2 +-
>  docs/specs/ppc-spapr-hotplug.txt    | 2 +-
>  docs/specs/ppc-xive.rst             | 2 +-
>  docs/specs/tpm.txt                  | 2 +-
>  include/hw/xen/interface/io/blkif.h | 2 +-
>  scripts/dump-guest-memory.py        | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/disas/libvixl/vixl/invalset.h b/disas/libvixl/vixl/invalset.h
> index ffdc0237b4..ef5e49d6fe 100644
> --- a/disas/libvixl/vixl/invalset.h
> +++ b/disas/libvixl/vixl/invalset.h
> @@ -102,7 +102,7 @@ template<TEMPLATE_INVALSET_P_DECL> class InvalSet {
>    size_t size() const;
>  
>    // Returns true if no elements are stored in the set.
> -  // Note that this does not mean the the backing storage is empty: it can still
> +  // Note that this does not mean the backing storage is empty: it can still
>    // contain invalid elements.
>    bool empty() const;
>  
> diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
> index 9f76d5bcf9..e926f0a6c9 100644
> --- a/docs/interop/pr-helper.rst
> +++ b/docs/interop/pr-helper.rst
> @@ -10,7 +10,7 @@ can delegate implementation of persistent reservations to an external
>  restricting access to block devices to specific initiators in a shared
>  storage setup.
>  
> -For a more detailed reference please refer the the SCSI Primary
> +For a more detailed reference please refer to the SCSI Primary
>  Commands standard, specifically the section on Reservations and the
>  "PERSISTENT RESERVE IN" and "PERSISTENT RESERVE OUT" commands.
>  
> diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotplug.txt
> index cc7833108e..859d52cce6 100644
> --- a/docs/specs/ppc-spapr-hotplug.txt
> +++ b/docs/specs/ppc-spapr-hotplug.txt
> @@ -385,7 +385,7 @@ Each LMB list entry consists of the following elements:
>    is used to retrieve the right associativity list to be used for this
>    LMB.
>  - A 32bit flags word. The bit at bit position 0x00000008 defines whether
> -  the LMB is assigned to the the partition as of boot time.
> +  the LMB is assigned to the partition as of boot time.
>  
>  ibm,dynamic-memory-v2
>  
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> index 148d57eb6a..83d43f658b 100644
> --- a/docs/specs/ppc-xive.rst
> +++ b/docs/specs/ppc-xive.rst
> @@ -163,7 +163,7 @@ Interrupt Priority Register (PIPR) is also updated using the IPB. This
>  register represent the priority of the most favored pending
>  notification.
>  
> -The PIPR is then compared to the the Current Processor Priority
> +The PIPR is then compared to the Current Processor Priority
>  Register (CPPR). If it is more favored (numerically less than), the
>  CPU interrupt line is raised and the EO bit of the Notification Source
>  Register (NSR) is updated to notify the presence of an exception for
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 5d8c26b1ad..9c8cca042d 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -89,7 +89,7 @@ TPM upon reboot. The PPI specification defines the operation requests and the
>  actions the firmware has to take. The system administrator passes the operation
>  request number to the firmware through an ACPI interface which writes this
>  number to a memory location that the firmware knows. Upon reboot, the firmware
> -finds the number and sends commands to the the TPM. The firmware writes the TPM
> +finds the number and sends commands to the TPM. The firmware writes the TPM
>  result code and the operation request number to a memory location that ACPI can
>  read from and pass the result on to the administrator.
>  
> diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
> index 8b1be50ce8..d07fa1e078 100644
> --- a/include/hw/xen/interface/io/blkif.h
> +++ b/include/hw/xen/interface/io/blkif.h
> @@ -341,7 +341,7 @@
>   *      access (even when it should be read-only). If the frontend hits the
>   *      maximum number of allowed persistently mapped grants, it can fallback
>   *      to non persistent mode. This will cause a performance degradation,
> - *      since the the backend driver will still try to map those grants
> + *      since the backend driver will still try to map those grants
>   *      persistently. Since the persistent grants protocol is compatible with
>   *      the previous protocol, a frontend driver can choose to work in
>   *      persistent mode even when the backend doesn't support it.
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 2c587cbefc..9371e45813 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -170,7 +170,7 @@ class ELF(object):
>          self.ehdr.e_phnum += 1
>  
>      def to_file(self, elf_file):
> -        """Writes all ELF structures to the the passed file.
> +        """Writes all ELF structures to the passed file.
>  
>          Structure:
>          Ehdr
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

