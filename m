Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA0C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B24820818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B24820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33853 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRLCy-00068o-0d
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 14:34:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRLBt-0005go-Nh
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRLBs-0001Nz-Ph
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:33:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRLBs-0001NW-JH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:33:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so4073889wmk.4
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 11:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=w/PmGZuioGQsoRNzLBeRtH6e/iEhk3NHl0OFNchiKPw=;
	b=ik4402FVmcYn9HF1BRE00EQG/Inq+xpLwk2Txt6OjRhdaYCJS66v+jG4UM3rDraY/a
	GMmW8l0w/jOfv4NxWCoUD88o3CGe7lEWPXEOrg/6/0S7Fap57bll6dekmxWCRykf+hua
	rDGrCj7T0GmbsGjRykCWMMUsXMZRlG34LQtY1C7EW6znhZcBOymV+4vW+q3KWZ/r6luL
	73SoqgePbi1GdCu7yI+ekrr5wdqrNvbTKMUbXKC34TeUbc4vPRVeHZ3nFLtEkD23V1pc
	OQtlROTzCEI9/0NsLtHX3SafX73lxw+00VOBR551irzF9jYsJzsRiT9fqht6M1VGB3Xc
	g7Ng==
X-Gm-Message-State: APjAAAXhs81MXIiq0v6ZHgYQVdk2ih8YveIetYFxRQwqpxWI07NFgZp/
	jQuOFo2icev5nxEEG+LSmEEK3w==
X-Google-Smtp-Source: APXvYqxzu5sobloZIom0gen8kEORILhZ0pF+Tzyfn5lNCcW/LXO6tYIzQOWexo4T/IYxFpbSI0vgUg==
X-Received: by 2002:a7b:c652:: with SMTP id q18mr18618461wmk.57.1558031594400; 
	Thu, 16 May 2019 11:33:14 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id j9sm7323917wrr.90.2019.05.16.11.33.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 11:33:13 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
Date: Thu, 16 May 2019 20:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
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

On 5/16/19 6:04 PM, Peter Maydell wrote:
> On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>
>> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32ebd73:
>>
>>   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-14 21:19:14 -0400)
>>
>> ----------------------------------------------------------------
>> pci, pc, virtio: features, fixes
>>
>> reconnect for vhost blk
>> tests for UEFI
>> misc other stuff
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> ----------------------------------------------------------------
> 
> Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
> because the conversion of arm to Kconfig has landed in master.
> Could you rebase and fix up to use whatever the Kconfig
> equivalent of these changes is, please?

Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"

The conflict doesn't look trivial to resolve (to me) so I'd rather see
it reviewed (by Thomas). I suggest to drop the patch(es) from your PR :(

Regards,

Phil.

