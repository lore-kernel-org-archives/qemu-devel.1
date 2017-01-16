Received: from eggs.gnu.org ([2001:4830:134:3::10]:45816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cT7o4-0008IK-Jr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cT7o1-0000gA-Uv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:58:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cT7o1-0000fw-M4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:58:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0GDnafP082780
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 08:58:39 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 280sw7651u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 08:58:39 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 16 Jan 2017 13:58:35 -0000
References: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA174989@DGGEMA505-MBX.china.huawei.com>
	<63cd3678-4044-365d-d396-1040f5755e2c@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA18DE85@DGGEMA505-MBX.china.huawei.com>
	<20170112214414-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DA18F9A0@DGGEMA505-MBX.china.huawei.com>
	<20170113175828-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DA1927AA@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 16 Jan 2017 14:58:24 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1927AA@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <9a9466e5-b626-1ba7-b8c8-65f310961ec4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v15 0/2] virtio-crypto:
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "john.griffin@intel.com" <john.griffin@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 01/16/2017 01:43 PM, Gonglei (Arei) wrote:
> Hi Michael and others,
> 
> I'd like to redefine struct virtio_crypto_op_data_req is as below: 
> 
> struct virtio_crypto_op_data_req {
>     struct virtio_crypto_op_header header;
> 
>     union {
>         struct virtio_crypto_sym_data_req   sym_req;
>         struct virtio_crypto_hash_data_req  hash_req;
>         struct virtio_crypto_mac_data_req   mac_req;
>         struct virtio_crypto_aead_data_req  aead_req;
>         struct virtio_crypto_sym_data_req_non_sess   sym_non_sess_req;
>         struct virtio_crypto_hash_data_req_non_sess  hash_non_sess_req;
>         struct virtio_crypto_mac_data_req_non_sess   mac_non_sess_req;
>         struct virtio_crypto_aead_data_req_non_sess  aead_non_sess_req;
> 		__u8 padding[72];
>     } u;
> };
> 
> The length of union in the structure will be changed, which from current 48 byte to 72 byte.
> 
> We couldn't redefine a structure named virtio_crypto_op_data_req_non_sess,
> Because the feature bits are for crypto services, not for the wrapper packet request.
> 

You mean virtio_crypto_op_data_req.virtio_crypto_op_header.flags
are conceptually meant for something else and using that field woulb
be misuse?


> It's impossible to mixed use struct virtio_crypto_op_data_req and 
> struct named virtio_crypto_op_data_req_non_sess for one data virtqueue.
> 

I do not understand what are you trying to say here. I think you
should tell us what is the new feature and how it is guarded.

Would this mean that session or non-session mode will be tied
to the whole device, or to one data-queue. If it's data-queue
level how is it controlled (e.g. control queue)?

I guess virtio_crypto_op_data_req.virtio_crypto_op_header.session_id
would become meaningless in case of non_sess?

> For driver compabity, I can submit patches for linux dirver and Qemu to change the length
> of struct virtio_crypto_op_data_req.u
> 
> Is the approach available?
>

In general and AFAIU any new behavior is possible, iff it
is appropriately guarded by some negotiation mechanism and
does not break per-existing code which knows nothing about
the new stuff.

I would not mind seeing a spec re-spin with a proper
proposal for session-less or stateless or whatever mode.

Cheers,
Halil
 
> Thanks,
> -Gonglei
> 
> 
>> -----Original Message-----
>> From: Gonglei (Arei)
>> Sent: Saturday, January 14, 2017 9:21 AM
>> To: 'Michael S. Tsirkin'
>> Cc: Halil Pasic; qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org;
>> Huangweidong (C); john.griffin@intel.com; cornelia.huck@de.ibm.com;
>> Zhoujian (jay, Euler); Varun.Sethi@freescale.com; denglingli@chinamobile.com;
>> arei.gonglei@hotmail.com; agraf@suse.de; nmorey@kalray.eu;
>> vincent.jardin@6wind.com; Ola.Liljedahl@arm.com; Luonengjun;
>> xin.zeng@intel.com; liang.j.ma@intel.com; stefanha@redhat.com; Shiqing Fan;
>> Jani Kokkonen; brian.a.keating@intel.com; Claudio Fontana;
>> mike.caraman@nxp.com; Wubin (H)
>> Subject: RE: [virtio-dev] Re: [Qemu-devel] [PATCH v15 0/2] virtio-crypto: virtio
>> crypto device specification
>>
>>>
>>> On Fri, Jan 13, 2017 at 02:54:29AM +0000, Gonglei (Arei) wrote:
>>>>
>>>>>
>>>>> On Thu, Jan 12, 2017 at 12:26:24PM +0000, Gonglei (Arei) wrote:
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> On 01/04/2017 11:10 AM, Gonglei (Arei) wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> I attach the diff files between v14 and v15 for better review.
>>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> only had a quick look. Will try to come back to this later.
>>>>>>>
>>>>>> That's cool.
>>>>>>
>>>>>>>> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
>>>>>>>> index 9f7faf0..884ee95 100644
>>>>>>>> --- a/virtio-crypto.tex
>>>>>>>> +++ b/virtio-crypto.tex
>>>>>>>> @@ -2,8 +2,8 @@
>>>>>>>>
>>>>>>>>  The virtio crypto device is a virtual cryptography device as well as a
>>> kind
>>>>> of
>>>>>>>>  virtual hardware accelerator for virtual machines. The encryption
>>> and
>>>>>>>> -decryption requests are placed in the data queue and are ultimately
>>>>> handled
>>>>>>> by the
>>>>>>>> -backend crypto accelerators. The second queue is the control queue
>>> used
>>>>> to
>>>>>>> create
>>>>>>>> +decryption requests are placed in any of the data active queues and
>>> are
>>>>>>> ultimately handled by the
>>>>>>> s/data active/active data/
>>>>>>>> +backend crypto accelerators. The second kind of queue is the
>> control
>>>>> queue
>>>>>>> used to create
>>>>>>>>  or destroy sessions for symmetric algorithms and will control some
>>>>>>> advanced
>>>>>>>>  features in the future. The virtio crypto device provides the
>> following
>>>>> crypto
>>>>>>>>  services: CIPHER, MAC, HASH, and AEAD.
>>>>>>>
>>>>>>> [..]
>>>>>>>
>>>>>>>> ===============The below diff shows the changes of add
>>> non-session
>>>>> mode
>>>>>>> support:
>>>>>>>>
>>>>>>>> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
>>>>>>>> index 884ee95..44819f9 100644
>>>>>>>> --- a/virtio-crypto.tex
>>>>>>>> +++ b/virtio-crypto.tex
>>>>>>>> @@ -26,7 +26,10 @@ N is set by \field{max_dataqueues}.
>>>>>>>>
>>>>>>>>  \subsection{Feature bits}\label{sec:Device Types / Crypto Device /
>>>>> Feature
>>>>>>> bits}
>>>>>>>>
>>>>>>>> -None currently defined.
>>>>>>>> +VIRTIO_CRYPTO_F_CIPHER_SESSION_MODE (1) Session mode is
>>>>> available
>>>>>>> for CIPHER service.
>>>>>>>> +VIRTIO_CRYPTO_F_HASH_SESSION_MODE (2) Session mode is
>>> available
>>>>> for
>>>>>>> HASH service.
>>>>>>>> +VIRTIO_CRYPTO_F_MAC_SESSION_MODE (3) Session mode is
>>> available
>>>>> for
>>>>>>> MAC service.
>>>>>>>> +VIRTIO_CRYPTO_F_AEAD_SESSION_MODE (4) Session mode is
>>> available
>>>>> for
>>>>>>> AEAD service.
>>>>>>>>
>>>>>>>>  \subsection{Device configuration layout}\label{sec:Device Types /
>>>>> Crypto
>>>>>>> Device / Device configuration layout}
>>>>>>>>
>>>>>>>> @@ -208,6 +211,9 @@ Operation parameters are
>> algorithm-specific
>>>>>>> parameters, output data is the
>>>>>>>>  data that should be utilized in operations, and input data is equal
>> to
>>>>>>>>  "operation result + result data".
>>>>>>>>
>>>>>>>> +The device can support both session mode (See \ref{sec:Device
>> Types
>>> /
>>>>>>> Crypto Device / Device Operation / Control Virtqueue / Session
>>> operation})
>>>>> and
>>>>>>> non-session mode, for example,
>>>>>>>> +As VIRTIO_CRYPTO_F_CIPHER_SESSION feature bit is negotiated,
>>> the
>>>>> driver
>>>>>>> can use session mode for CIPHER service, otherwise it can only use
>>>>> non-session
>>>>>>> mode.
>>>>>>>> +
>>>>>>>
>>>>>>> As far as I understand you are adding non-session mode to the mix but
>>>>>>> providing feature bits for session mode. Would this render the the
>>> current
>>>>>>> implementation non-compliant?
>>>>>>>
>>>>>> You are right, shall we use feature bits for non-session mode for
>>> compliancy?
>>>>>> Or because the spec is on the fly, and some structures in the
>>> virtio_crypto.h
>>>>> need to
>>>>>> be modified, can we keep the compliancy completely?
>>>>>>
>>>>>> Thanks,
>>>>>> -Gonglei
>>>>>
>>>>> Since there's a linux driver upstream you must at least
>>>>> keep compatibility with that.
>>>>>
>>>> Sure. We use feature bits for non-session mode then.
>>>> For structures modification, do we need to do some specific
>>>> actions for compatibility?  Take CIPHER service as an example:
>>>>
>>>> The present structure:
>>>>
>>>> struct virtio_crypto_cipher_para {
>>>>     /*
>>>>      * Byte Length of valid IV/Counter data pointed to by the below iv
>> data.
>>>>      *
>>>>      * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or
>> for
>>>>      *   SNOW3G in UEA2 mode, this is the length of the IV (which
>>>>      *   must be the same as the block length of the cipher).
>>>>      * For block ciphers in CTR mode, this is the length of the counter
>>>>      *   (which must be the same as the block length of the cipher).
>>>>      */
>>>>     le32 iv_len;
>>>>     /* length of source data */
>>>>     le32 src_data_len;
>>>>     /* length of destination data */
>>>>     le32 dst_data_len;
>>>> };
>>>>
>>>> The future structure if supporting non-session based operations:
>>>>
>>>> struct virtio_crypto_cipher_para {
>>>>     struct {
>>>>         /* See VIRTIO_CRYPTO_CIPHER* above */
>>>>         le32 algo;
>>>>         /* length of key */
>>>>         le32 keylen;
>>>>
>>>>         /* See VIRTIO_CRYPTO_OP_* above */
>>>>         le32 op;
>>>>     } sess_para;
>>>>
>>>>     /*
>>>>      * Byte Length of valid IV/Counter data pointed to by the below iv
>> data.
>>>>      *
>>>>      * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or
>> for
>>>>      *   SNOW3G in UEA2 mode, this is the length of the IV (which
>>>>      *   must be the same as the block length of the cipher).
>>>>      * For block ciphers in CTR mode, this is the length of the counter
>>>>      *   (which must be the same as the block length of the cipher).
>>>>      */
>>>>     le32 iv_len;
>>>>     /* length of source data */
>>>>     le32 src_data_len;
>>>>     /* length of destination data */
>>>>     le32 dst_data_len;
>>>> };
>>>>
>>>> Thanks,
>>>> -Gonglei
>>>
>>> So you will have to maintain both structures for when non-session based
>>> feature is and aren't present. You will have to give them different
>>> names, too.
>>>
>> OK, I get your point. :)
>>
>> Thanks,
>> -Gonglei
> 
> 
