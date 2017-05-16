Received: from eggs.gnu.org ([2001:4830:134:3::10]:49388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAaE9-0005Sw-ES
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAaE6-00081m-TH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:01:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dAaE6-00081K-KW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:01:14 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4GAxRZo140473
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:01:12 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2afxk1w77f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:01:12 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 16 May 2017 12:00:58 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<1e56f82e-6afb-af30-acb9-6f66373c7bc2@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA29A11A@DGGEMA505-MBS.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 16 May 2017 13:00:39 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA29A11A@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <1bd450f1-66f0-2603-7ac1-6dd99c74d49a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v18 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "lixiao (H)" <lixiao91@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Zhbzg <zhbzg@huawei.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Linqiangmin <linqiangmin@huawei.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 05/16/2017 05:48 AM, Gonglei (Arei) wrote:

[..]
>>> +\begin{itemize*}
>>> +\item The device MUST set the \field{session_id} field to a unique session
>> identifier when the device finishes processing session creation.
>>
>> I guess only if successfull (that is status == VIRTIO_CRYPTO_OK).
>>
> Sure. Let me add the condition.
> 
>>> +\item The device MUST set the \field{status} field to one of the values of
>> enum VIRTIO_CRYPTO_STATUS.
>>
>> Maybe put this one first. The formulation could be more fortunate in
>> a sense that it's required to set the right status (_OK if successs,
>> _NOTSUPP if ...).
>>
>> What shall happen if the operation fails, e.g. becasue of out of resources?
>>
> That means the driver can't create session, and the following crypto
> operation are forbidden.
> 

I wanted to ask which status code has to be used in what case? Is it always
_ERR or _NOTSUPP?

>> Is there some sort of limit for the amount of live sessions (related to
>> the previous question)? Obviously the device needs storage for the
>> session data. Can the guest DOS attack the host by creating an absurd number
>> of sessions?
>>
> Good question. It's true that the guest can trigger DoS attack.
> What's your opinion about the limit in the spec? Add a new feature?
> 

Adding a new feature does not seem like a good idea to me, because
if the guest can turn of the safety mechanism (not negotiate the
corresponding feature), then we are almost back to where we started.

My idea would be to specify how is the device (and maybe also the driver,
I can't tell) supposed to fail if max_session is reached. The device should
just set some proper status for the request I guess. We could also
make the maximal number of sessions an implementation defined property
of the device, and expose it via configuration space.

Hard limit in the spec is also viable, but in that case we also need
to specify what happens if the limit is reached.

[..]

>>> +\subsubsection{Data Virtqueue}\label{sec:Device Types / Crypto Device /
>> Device Operation / Data Virtqueue}
>>> +
>>> +The driver uses the data virtqueue to transmit crypto operation requests to
s/virtqueue/virtqueues
We may have more than one dataq

>> the device,
>>> +and completes the crypto operations.
>>> +
>>> +Session mode dataq requests are as follows:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_crypto_op_data_req {
>>> +    struct virtio_crypto_op_header header;
>>> +
>>> +    union {
>>> +        struct virtio_crypto_sym_data_req   sym_req;
>>> +        struct virtio_crypto_hash_data_req  hash_req;
>>> +        struct virtio_crypto_mac_data_req   mac_req;
>>> +        struct virtio_crypto_aead_data_req  aead_req;
>>> +    } u;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +Dataq requests for both session and stateless modes are as follows:
>>
>> This ain't very nice, I mean the 'both session and stateless modes' together
> 
> So what's your idea?
> 

As I have pointed out while reviewing the QEMU implementation of the stateless
mode I'm not satisfied with the description of the request format(s).

This here is rather a  cosmetic issue, and my idea was to replace
'Session mode dataq requests' with 'If MUX_MODE feature bit is not
negotiated the dataq requests'. And also replace 'Dataq requests for both
session and stateless modes are' with 'If MUX_MODE feature bit is
negotiated the dataq requests are'.

In my eyes, how these requests are described is a much bigger problem.

>> with the above 'session mode dataq requests are'. In the meanwhile I know
>> what
>> you mean: if the SESSION_MODE feature bit was negotiated.
>>
> Yes, that's what I want. If the MUX_MODE feature bit is negotiated, the
> driver MUST use struct virtio_crypto_op_data_req_mux for requests.
> 
> 
[..]
>>
>> OK, I have read this to the end and I don't think there is anything which requires
>> a comment at this stage. I would like to concentrate on your QEMU patches
>> first,
>> and I think we have enough questions/issues already.
>>
> 
> Great thanks for your comments. Pls go ahead. :)

Your are welcome.

Regards,
Halil

> 
> Thanks,
> -Gonglei
> 
> 
