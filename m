Received: from eggs.gnu.org ([2001:4830:134:3::10]:45776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lovemrd@gmail.com>) id 1fI9Le-0003WB-VL
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lovemrd@gmail.com>) id 1fI9LZ-0000dC-0l
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:00:51 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:47037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lovemrd@gmail.com>) id 1fI9LY-0000cw-RT
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:00:44 -0400
Received: by mail-qk0-x242.google.com with SMTP id s70-v6so9323892qks.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 02:00:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511082601.36ded6c1@t450s.home>
References: <CAF_Z_jqQDvdvPoQkpvrgmtJSaJxaFbATpc0toJBRjAnO9gHupA@mail.gmail.com>
	<20180511082601.36ded6c1@t450s.home>
From: Zhu Yijun <lovemrd@gmail.com>
Date: Mon, 14 May 2018 17:00:43 +0800
Message-ID: <CAF_Z_joAEyETvEJAfm9MLwOMxXT=ZLt1+kBjuwnXdq2VfzeSUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] ping latency issue on passthrough guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Alex,

    Thanks for your reply, I will try to assign PF to VM and test.

2018-05-11 22:26 GMT+08:00 Alex Williamson <alex.williamson@redhat.com>:
> On Fri, 11 May 2018 15:20:05 +0800
> Zhu Yijun <lovemrd@gmail.com> wrote:
>
>> Hi all,
>>
>>   I booted two sr-iov guests using KVM-VFIO and pinged each other with
>> no-load one night. I found that most of the latency was little than 0.1ms,
>> but several icmp_seq greater than 10ms, even up to 1000ms;
>>
>>   root@test-ping01:~# grep "time=[0-9][0-9]" outputfile
>> Mon May  7 23:05:12 201864 bytes from 192.168.0.200: icmp_seq=16703 ttl=64
>> time=123 ms
> ...
>>
>>    VF used by these two guest from same port(eth0) of intel X710 Ethernet
>> controller. By contrast, I selected another two VFs and set them to
>> separate network namespace, this issue did not exits, all the latency
>> litter than 0.2ms.
>
> I think you've proved by this experiment that it's not likely to be a
> device assignment issue.  Device assignment knows nothing about the
> device above the base PCI level operation, so if changing the
> networking configuration resolves the issue, the problem is perhaps
> more likely in how the PF, or maybe the guest itself, is routing VF
> packets.  Thanks,
>
> Alex
