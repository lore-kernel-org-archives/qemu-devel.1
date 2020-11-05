Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F7C388F9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828E02072C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEBmX6na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828E02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWEy-0004ig-8o
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kaWEN-0004Jq-0R
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 22:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kaWEK-000332-M5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 22:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604547990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXM8TA/WnHaF9AzQBruktsLJJSNG7pP9SvEx2+w6nG0=;
 b=UEBmX6navR54sj4afOL8iyndY29Up9xYWZd37uGuSsB+nmU5VBNgcMsHuYSoA11MEy5oVf
 bzWgOvvhaM5NHbeHfFkNh73049Z1frkMXJ/4a7+ZqDbc+YZXZIDZXyCQUHU21R81cAJS2D
 cJjFoI+zJRw2LSvrYG3lrF48WkEELik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-00PKAT_yP5a8LN5A5q-3Dw-1; Wed, 04 Nov 2020 22:46:26 -0500
X-MC-Unique: 00PKAT_yP5a8LN5A5q-3Dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92D188049CB;
 Thu,  5 Nov 2020 03:46:25 +0000 (UTC)
Received: from [10.72.13.154] (ovpn-13-154.pek2.redhat.com [10.72.13.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD1F51002C13;
 Thu,  5 Nov 2020 03:46:19 +0000 (UTC)
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <caa38709-88f1-bd6d-3ff9-61e64c3aa51f@redhat.com>
 <20201104093155.GB565323@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cc53c09c-9b3c-63e1-6df3-b5fc949e626c@redhat.com>
Date: Thu, 5 Nov 2020 11:46:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104093155.GB565323@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/4 下午5:31, Daniel P. Berrangé wrote:
> On Wed, Nov 04, 2020 at 10:07:52AM +0800, Jason Wang wrote:
>> On 2020/11/3 下午6:32, Yuri Benditovich wrote:
>>>
>>> On Tue, Nov 3, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com
>>> <mailto:jasowang@redhat.com>> wrote:
>>>
>>>
>>>      On 2020/11/3 上午2:51, Andrew Melnychenko wrote:
>>>      > Basic idea is to use eBPF to calculate and steer packets in TAP.
>>>      > RSS(Receive Side Scaling) is used to distribute network packets
>>>      to guest virtqueues
>>>      > by calculating packet hash.
>>>      > eBPF RSS allows us to use RSS with vhost TAP.
>>>      >
>>>      > This set of patches introduces the usage of eBPF for packet steering
>>>      > and RSS hash calculation:
>>>      > * RSS(Receive Side Scaling) is used to distribute network packets to
>>>      > guest virtqueues by calculating packet hash
>>>      > * eBPF RSS suppose to be faster than already existing 'software'
>>>      > implementation in QEMU
>>>      > * Additionally adding support for the usage of RSS with vhost
>>>      >
>>>      > Supported kernels: 5.8+
>>>      >
>>>      > Implementation notes:
>>>      > Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF program.
>>>      > Added eBPF support to qemu directly through a system call, see the
>>>      > bpf(2) for details.
>>>      > The eBPF program is part of the qemu and presented as an array
>>>      of bpf
>>>      > instructions.
>>>      > The program can be recompiled by provided Makefile.ebpf(need to
>>>      adjust
>>>      > 'linuxhdrs'),
>>>      > although it's not required to build QEMU with eBPF support.
>>>      > Added changes to virtio-net and vhost, primary eBPF RSS is used.
>>>      > 'Software' RSS used in the case of hash population and as a
>>>      fallback option.
>>>      > For vhost, the hash population feature is not reported to the guest.
>>>      >
>>>      > Please also see the documentation in PATCH 6/6.
>>>      >
>>>      > I am sending those patches as RFC to initiate the discussions
>>>      and get
>>>      > feedback on the following points:
>>>      > * Fallback when eBPF is not supported by the kernel
>>>
>>>
>>>      Yes, and it could also a lacking of CAP_BPF.
>>>
>>>
>>>      > * Live migration to the kernel that doesn't have eBPF support
>>>
>>>
>>>      Is there anything that we needs special treatment here?
>>>
>>> Possible case: rss=on, vhost=on, source system with kernel 5.8
>>> (everything works) -> dest. system 5.6 (bpf does not work), the adapter
>>> functions, but all the steering does not use proper queues.
>>
>> Right, I think we need to disable vhost on dest.
>>
>>
>>>
>>>
>>>      > * Integration with current QEMU build
>>>
>>>
>>>      Yes, a question here:
>>>
>>>      1) Any reason for not using libbpf, e.g it has been shipped with some
>>>      distros
>>>
>>>
>>> We intentionally do not use libbpf, as it present only on some distros.
>>> We can switch to libbpf, but this will disable bpf if libbpf is not
>>> installed
>>
>> That's better I think.
>>
>>
>>>      2) It would be better if we can avoid shipping bytecodes
>>>
>>>
>>>
>>> This creates new dependencies: llvm + clang + ...
>>> We would prefer byte code and ability to generate it if prerequisites
>>> are installed.
>>
>> It's probably ok if we treat the bytecode as a kind of firmware.
> That is explicitly *not* OK for inclusion in Fedora. They require that
> BPF is compiled from source, and rejected my suggestion that it could
> be considered a kind of firmware and thus have an exception from building
> from source.


Please refer what it was done in DPDK:

http://git.dpdk.org/dpdk/tree/doc/guides/nics/tap.rst#n235

I don't think what proposed here makes anything different.

It's still a bytecode that lives in an array.


>
>> But in the long run, it's still worthwhile consider the qemu source is used
>> for development and llvm/clang should be a common requirement for generating
>> eBPF bytecode for host.
> So we need to do this right straight way before this merges.


Yes.

Thanks


>
> Regards,
> Daniel


