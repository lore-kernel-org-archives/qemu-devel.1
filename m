Received: from eggs.gnu.org ([2001:4830:134:3::10]:42255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dqCr0-0002Dm-TE
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dqCqv-0004Ky-PP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:33:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dqCqv-0004G5-2v
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:33:21 -0400
Message-ID: <59B23980.4070105@huawei.com>
Date: Fri, 8 Sep 2017 14:32:32 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1503734014-239116-1-git-send-email-longpeng2@huawei.com>
	<59A8AE20.1080409@huawei.com>
	<20170908064744-mutt-send-email-mst@kernel.org>
	<59B21AE9.1090808@huawei.com>
	<20170908073027-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170908073027-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v19 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cohuck@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com



On 2017/9/8 12:31, Michael S. Tsirkin wrote:

> On Fri, Sep 08, 2017 at 12:22:01PM +0800, Longpeng (Mike) wrote:
>>
>>
>> On 2017/9/8 11:49, Michael S. Tsirkin wrote:
>>
>>> On Fri, Sep 01, 2017 at 08:47:28AM +0800, Longpeng (Mike) wrote:
>>>> Ping...
>>>>
>>>> Stefan, Halil, do you have any suggestion ?
>>>
>>> I do not see this patchset in the virtio list archives.
>>> It could be that youa re posting from an email that is
>>> not a subscriber.
>>>
>>> Please subscribe and repost.
>>>
>>
>>
>> OK, I'll subscribe and repost after I complete the implementation based on the
>> v19 :)
> 
> To clarify does not existing device in qemu work according to
> this spec? We need to make the spec compatible with what's
> out there in the field somehow (feature bit?).


Yep, the spec is compatible with the existing device in QEMU by a feature
bit(VIRTIO_CRYPTO_F_MUX_MODE).

> 
>>> We'll then have to allow up to 2 weeks for comments.
>>>
>>> Halil, I hope this timing works for you.
>>>
>>>> -- 
>>>> Regards,
>>>> Longpeng(Mike)
>>>>
>>>> On 2017/8/26 15:53, Longpeng(Mike) wrote:
>>>>
>>>>> Hi guys,
>>>>>
>>>>> I'll work on the virtio-crypto spec with Gonglei together, Because He is
>>>>> so busy on the inner production project.
>>>>>
>>>>> ---
>>>>> v19 -> v18:
>>>>>  - fix some typos and grammar fixes [Stefan, Halil]
>>>>>  - rename VIRTIO_CRYPTO_F_STATELESS_MODE to VIRTIO_CRYPTO_F_MUX_MODE
>>>>>  - describe the VIRTIO_CRYPTO_STATUS in detial. [Halil]
>>>>>  - refactor and redescribe the controlq/dataq request's format
>>>>>    of mux mode. [Halil]
>>>>>  - other small fixes. [Halil]
>>>>>
>>>>> v18 -> v17:
>>>>>  - fix many English grammar problems suggested by Stefan, Thanks a lot!
>>>>>
>>>>> v17 -> v16:
>>>>>  - Some grammar fixes [Stefan, Halil, Michael]
>>>>>  - add a section named "Supported crypto services" in order to explain bit
>>>>>    numbers and valuse clearly. [Halil, Cornelia]
>>>>>  - avoid word reptition [Halil]
>>>>>  - rename non-session mode to stateless mode [Halil]
>>>>>  - change descriptions for all elements in struct virtio_crypto_config [Halil]
>>>>>  - add Halil as a reviewer in the ackonwledgement part, thanks for his work.
>>>>>  - other fixes here and there.
>>>>>
>>>>> Changes since v15:
>>>>>  - use feature bits for non-session mode in order to keep compatibility with
>>>>>    pre-existing code. [Halil & Michael]
>>>>>  - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control all other
>>>>>    non-session mode feature bits.
>>>>>  - fix some typos. [Stefan]
>>>>>  - introduce struct virtio_crypto_op_data_req_mux to support both session
>>>>>    and non-session based crypto operations and keep compatibility with
>>>>>    pre-existing code.
>>>>>
>>>>> Changes since v14:
>>>>>  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
>>>>>  - correct a sentence about dataqueue and controlq in the first paragraph. 
>>>>> [Halil]
>>>>>  - change a MAY to MUST about max_dataqueues. [Halil]
>>>>>  - add non-session mode support
>>>>>    a) add four features for different crypto services to identify wheather 
>>>>> support session mode.
>>>>>    b) rewrite some
>>>>>
>>>>> For pervious versions of virtio crypto spec, Pls see:
>>>>>
>>>>> [v18]:
>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg444897.html
>>>>>
>>>>> [v14]:
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
>>>>>
>>>>> [v13]:
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
>>>>>
>>>>> For more information, please see:
>>>>>  http://qemu-project.org/Features/VirtioCrypto
>>>>>
>>>>> ---
>>>>> Gonglei (2):
>>>>>   virtio-crypto: Add virtio crypto device specification
>>>>>   virtio-crypto: Add conformance clauses
>>>>>
>>>>>  acknowledgements.tex |    3 +
>>>>>  conformance.tex      |   29 +
>>>>>  content.tex          |    2 +
>>>>>  virtio-crypto.tex    | 1470 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  4 files changed, 1504 insertions(+)
>>>>>  create mode 100644 virtio-crypto.tex
>>>>>
>>>>
>>>>
>>>> -- 
>>>> Regards,
>>>> Longpeng(Mike)
>>>
>>> .
>>>
>>
>>
>> -- 
>> Regards,
>> Longpeng(Mike)
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
