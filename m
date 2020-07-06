Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A64C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9942070B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9942070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsS9B-0000sy-MM
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jsS8Z-0000Ek-H0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:30:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:40222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jsS8X-00039d-G4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:30:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3F69EAD89;
 Mon,  6 Jul 2020 14:30:23 +0000 (UTC)
Subject: Re: [PULL 00/10] Modules 20200702 patches
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200702122048.27798-1-kraxel@redhat.com>
 <CAFEAcA9PVnKo8S7=bSggS2FpS5YoBexZD7nM54XFHto333_OhQ@mail.gmail.com>
 <20200703103949.7vz3dmy4br55rh4b@sirius.home.kraxel.org>
 <d9e28e08-e8d3-edd4-dcf0-af207a5ad3b8@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <b6d38863-1427-8721-5743-cd73e743bf40@suse.de>
Date: Mon, 6 Jul 2020 16:30:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d9e28e08-e8d3-edd4-dcf0-af207a5ad3b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 21:32:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 2:05 PM, Paolo Bonzini wrote:
> On 03/07/20 12:39, Gerd Hoffmann wrote:
>> On Fri, Jul 03, 2020 at 09:54:13AM +0100, Peter Maydell wrote:
>>> On Thu, 2 Jul 2020 at 13:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>>
>>>> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>>>>
>>>>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kraxel.org/qemu tags/modules-20200702-pull-request
>>>>
>>>> for you to fetch changes up to 474a5d66036d18ee5ccaa88364660d05bf32127b:
>>>>
>>>>   chardev: enable modules, use for braille (2020-07-01 21:08:11 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> qom: add support for qom objects in modules.
>>>> build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
>>>> build braille chardev as module.
>>>>
>>>> note: qemu doesn't rebuild objects on cflags changes (specifically
>>>>       -fPIC being added when code is switched from builtin to module).
>>>>       Workaround for resulting build errors: "make clean", rebuild.
>>>>
>>>> ----------------------------------------------------------------
>>>>
>>>> Gerd Hoffmann (10):
>>>>   module: qom module support
>>>>   object: qom module support
>>>>   qdev: device module support
>>>>   build: fix device module builds
>>>>   ccid: build smartcard as module
>>>>   usb: build usb-redir as module
>>>>   vga: build qxl as module
>>>>   vga: build virtio-gpu only once
>>>>   vga: build virtio-gpu as module
>>>>   chardev: enable modules, use for braille
>>>
>>> No code review at all? :-(
>>
>> Well, there have been 5 revisions on the list, partly due to bugs being
>> fixed, partly with changes as response to review comments.  So it got
>> some review (not much though) even though the v5 series (posted on June
>> 22th, so there was more than a week time) didn't got any acks so far.
>>
>>> In particular the "build: fix device module
>>> builds" commit (as you note in your commit message) does not look at
>>> all right.
>>
>> I think this stop-gap will do fine as long as we don't have any
>> target-specific modules.
> 
> Yeah, it's hackish but target-specific modules would be a huge
> complication so I don't think we'd be having them anytime soon.  With
> Meson removing the unnest-vars logic, the hack would also go away on its
> own.  So I guess it's okay.
> 
> Paolo
> 
> 

Hi Paolo,

well, since it is one of my main objectives behind lots of the refactoring work I have in progress,
and have been announcing this to the list since May:

https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg04628.html

I would disagree with the fact that target-specific modules are a huge complication in by themselves, as I got some initial promising results in building them.

Will work on the series and contribute it as soon as the basic requisite initial refactoring series are in,
so that the usefulness of target-specific modules can be demonstrated.

In my view modules could have been implemented differently, instead of the current design, in a way that would have made them easier to extend.

Probably meson is an interesting tool, I think however that good build designs will still be necessary,
and that bad ones will still result in difficult to extend build features.

Thanks & ciao,

Claudio


