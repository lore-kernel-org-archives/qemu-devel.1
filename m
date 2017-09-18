Received: from eggs.gnu.org ([2001:4830:134:3::10]:37452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dtkhY-0007Mt-Nf
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 21:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dtkhU-000775-6Q
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 21:18:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dtkhT-00073G-Hs
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 21:18:16 -0400
Message-ID: <59BF1E9B.2030408@huawei.com>
Date: Mon, 18 Sep 2017 09:17:15 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
	<2d8ae3d3-438b-da84-4959-cf63f4f4ce99@linux.vnet.ibm.com>
	<59B9D439.10807@huawei.com>
	<7e490af1-9caa-c96d-5f62-308f1b5d8805@linux.vnet.ibm.com>
In-Reply-To: <7e490af1-9caa-c96d-5f62-308f1b5d8805@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [RFC 0/8]
 virtio-crypto: add multiplexing mode support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: weidong.huang@huawei.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, john.griffin@intel.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, virtio-dev@lists.oasis-open.org, agraf@suse.de, arei.gonglei@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, Jani.Kokkonen@huawei.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, cohuck@redhat.com, mike.caraman@nxp.com



On 2017/9/16 1:33, Halil Pasic wrote:

> 
> 
> On 09/14/2017 02:58 AM, Longpeng (Mike) wrote:
>>
>>
>> On 2017/9/14 2:14, Halil Pasic wrote:
>>
>>>
>>>
>>> On 09/11/2017 03:10 AM, Longpeng(Mike) wrote:
>>>> *NOTE*
>>>> The code realization is based on the latest virtio crypto spec:
>>>>  [PATCH v19 0/2] virtio-crypto: virtio crypto device specification
>>>>    https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05217.html
>>>>
>>>> In session mode, the process of create/close a session
>>>> makes we have a least one full round-trip cost from guest to host to guest
>>>> to be able to send any data for symmetric algorithms. It gets ourself into
>>>> synchronization troubles in some scenarios like a web server handling lots
>>>> of small requests whose algorithms and keys are different.
>>>>
>>>> We can support one-blob request (no sessions) as well for symmetric
>>>> algorithms, including HASH, MAC services. The benefit is obvious for
>>>> HASH service because it's usually a one-blob operation.
>>>>
>>>
>>> Hi!
>>>
>>> I've just started looking at this. Patch #1 modifies linux/virtio_crypto.h
>>> which if I compare with the (almost) latest linux master is different. Thus
>>> I would expect a corresponding kernel patch set too, but I haven't received
>>> one, nor did I find a reference in the cover letter.
>>>
>>> I think if I want to test the new features I need the kernel counter-part
>>> too, or?
>>>
>>> Could you point me to the kernel counterpart?
>>>
>>
>>
>> Hi Halil,
>>
>> We haven't implemented the kernel frontend part yet, but there's a testcase
>> based on qtest, you can use it.
>>
>> Please see the attachment.
>>
> 
> Thanks Longpeng! I have two problems with this: first I can't use this on s390x
> and as you may have noticed I'm working mostly on s390x (that's what I'm payed
> for). OK, my laptop is amd64 so I was able to try it out, and that leads to the
> next problem. I can't test before/after and cross version stuff with this. That
> hurts me because I have a feeling things can be done simpler but that feeling has
> failed me before, so I tend to try out first and then start a discussion.
> 
> Is some kernel patch series already in the pipeline? 
> 


Hi Halil，

Thank for your comments about the v19 spec first, we'll close look at them recently.

I'm so sorry that the kernel frontend driver isn't in the pipeline, so maybe you
can start a x86/tcg VM on your s390x machine or amd64 laptop and then debug this
feature with the testcase.

If it's not convenient to you, I'll wrote an experimental version of the kernel
frontend driver these days. :)

-- 
Regards,
Longpeng(Mike)

> Regards,
> Halil
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
