Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0281C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927DA2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 07:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927DA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1xp-0007tk-Nh
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 03:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jc1xK-0007Tf-Fx
 for qemu-devel@nongnu.org; Fri, 22 May 2020 03:18:58 -0400
Received: from david.siemens.de ([192.35.17.14]:34491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jc1xF-0006OS-OK
 for qemu-devel@nongnu.org; Fri, 22 May 2020 03:18:56 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 04M7Imud030437
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 09:18:48 +0200
Received: from [139.22.32.53] ([139.22.32.53])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 04M7IkdP022393;
 Fri, 22 May 2020 09:18:47 +0200
Subject: Re: [RFC][PATCH v2 2/3] docs/specs: Add specification of ivshmem
 device revision 2
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1578407802.git.jan.kiszka@siemens.com>
 <5ddc4ca4f32bfab8971840e441b60a72153a2308.1578407802.git.jan.kiszka@siemens.com>
 <877dx5fcvo.fsf@linaro.org> <20200521141642-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55386d9d-0748-8cad-494e-5955a22ebd09@siemens.com>
Date: Fri, 22 May 2020 09:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521141642-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.35.17.14; envelope-from=jan.kiszka@siemens.com;
 helo=david.siemens.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 03:18:50
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.05.20 20:18, Michael S. Tsirkin wrote:
> On Thu, May 21, 2020 at 05:53:31PM +0100, Alex Bennée wrote:
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This imports the ivshmem v2 specification draft from Jailhouse where the
>>> implementation is about to be merged now. The final home of the spec is
>>> to be decided, this shall just simplify the review process at this
>>> stage.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  docs/specs/ivshmem-2-device-spec.md | 376 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 376 insertions(+)
>>>  create mode 100644 docs/specs/ivshmem-2-device-spec.md
>>>
>>> diff --git a/docs/specs/ivshmem-2-device-spec.md b/docs/specs/ivshmem-2-device-spec.md
>>> new file mode 100644
>>> index 0000000000..d93cb22b04
>>> --- /dev/null
>>> +++ b/docs/specs/ivshmem-2-device-spec.md
>>> @@ -0,0 +1,376 @@
>>> +IVSHMEM Device Specification
>>> +============================
>>> +
>>> +** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE
>>> SPECIFICATION! **
>>
>> Has there been any proposal to the OASIS virtio spec to use this as a
>> transport for VirtIO?
>>

Not yet, primarily because the second half - virtio over generic shared
memory or even ivshmem2 in particular - has not been written yet. It
only exists as prototypes. Lacking time.

>> -- 
>> Alex Bennée
> 
> 
> I think intergrating this in the virtio spec needs not gate the
> implementation, but I'd like to see the current spec copied to
> virtio-comments list to possibly get comments from that community.
> 
> 

Will do.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

