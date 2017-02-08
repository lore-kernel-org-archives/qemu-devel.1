Received: from eggs.gnu.org ([2001:4830:134:3::10]:60220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cbSHg-0005NR-CS
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cbSHd-00028u-1V
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:27:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52657
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cbSHc-00027E-P4
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:27:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v18DODZo032131
	for <qemu-devel@nongnu.org>; Wed, 8 Feb 2017 08:27:39 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28fgmu7das-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 08:27:38 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Feb 2017 13:27:35 -0000
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<62a99d8e-1735-0838-4067-bce401c86526@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA1AFFB2@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 8 Feb 2017 14:27:26 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1AFFB2@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <ee910162-d6ff-4648-752e-fbb3d6077a37@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v16 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>



On 02/08/2017 07:24 AM, Gonglei (Arei) wrote:
> Hi Halil,
> 
> Thanks for your comments firstly.
> 

You are welcome :). Sorry it took so long -- I'm currently
quite busy.

>>
>> On 01/18/2017 09:22 AM, Gonglei wrote:
>>> The virtio crypto device is a virtual crypto device (ie. hardware
>>> crypto accelerator card). Currently, the virtio crypto device provides
>>> the following crypto services: CIPHER, MAC, HASH, and AEAD.
>>>
>>> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
>>>
>>> VIRTIO-153
>>>
>>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: Lingli Deng <denglingli@chinamobile.com>
>>> CC: Jani Kokkonen <Jani.Kokkonen@huawei.com>
>>> CC: Ola Liljedahl <Ola.Liljedahl@arm.com>
>>> CC: Varun Sethi <Varun.Sethi@freescale.com>
>>> CC: Zeng Xin <xin.zeng@intel.com>
>>> CC: Keating Brian <brian.a.keating@intel.com>
>>> CC: Ma Liang J <liang.j.ma@intel.com>
>>> CC: Griffin John <john.griffin@intel.com>
>>> CC: Mihai Claudiu Caraman <mike.caraman@nxp.com>
>>> ---
>>>  content.tex       |    2 +
>>>  virtio-crypto.tex | 1245
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 1247 insertions(+)
>>>  create mode 100644 virtio-crypto.tex
>>>
>>> diff --git a/content.tex b/content.tex
>>> index 4b45678..ab75f78 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -5750,6 +5750,8 @@ descriptor for the \field{sense_len},
>> \field{residual},
>>>  \field{status_qualifier}, \field{status}, \field{response} and
>>>  \field{sense} fields.
>>>
>>> +\input{virtio-crypto.tex}
>>> +
>>>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>>
>>>  Currently there are three device-independent feature bits defined:
>>> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
>>> new file mode 100644
>>> index 0000000..732cd30
>>> --- /dev/null
>>> +++ b/virtio-crypto.tex
>>> @@ -0,0 +1,1245 @@
>>> +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
>>> +
>>> +The virtio crypto device is a virtual cryptography device as well as a kind of
>>> +virtual hardware accelerator for virtual machines. The encryption and
>>> +decryption requests are placed in any of the data active queues and are
>> ultimately handled by the
>>
>> Am I the only one having a problem with 'data active queues'?
> 
> Maybe 'data queues' here is enough?
> 

I guess 'active' came from virtio-net. For virtio-crypto you do not define
active and passive queues, and my guess is there is no intention/reason
to do this in the future either. Thus yes 'data queues' is fine. And
'active data queues' would be grammatically correct, but substantially
confusing and wrong.

>> I have objected on this before.
>>
>>> +backend crypto accelerators. The second kind of queue is the control queue
>> used to create
>>> +or destroy sessions for symmetric algorithms and will control some
>> advanced
>>> +features in the future. The virtio crypto device provides the following crypto
>>> +services: CIPHER, MAC, HASH, and AEAD.
>>> +
>>> +
>>> +\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device ID}
>>> +
>>> +20
>>> +
>>> +\subsection{Virtqueues}\label{sec:Device Types / Crypto Device /
>> Virtqueues}
>>> +
>>> +\begin{description}
>>> +\item[0] dataq1
>>> +\item[\ldots]
>>> +\item[N-1] dataqN
>>> +\item[N] controlq
>>> +\end{description}
>>> +
>>> +N is set by \field{max_dataqueues}.
>>> +
>>> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature
>> bits}
>>> +
>>> +VIRTIO_CRYPTO_F_NON_SESSION_MODE (0) non-session mode is available.
>>> +VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is
>> available for CIPHER service.
>>> +VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is
>> available for HASH service.
>>> +VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is
>> available for MAC service.
>>> +VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is
>> available for AEAD service.
>>> +
>>
>> I'm not sure that "non-session" entirely correct grammatically. I would
>> prefer sessionless as alternatively proposed by Stefan, or even stateless.
>> I think stateless is the phrase most frequently used to describe what
>> we want to introduce -- that is basically response = f(request) and
>> not response = f(request, server_state) where the server_state is
>> a is determined by a series of previous interactions between the server
>> and the client).
>>
> Makes sense. I discussed with Xin about this on call meeting two weeks ago.
> I decide to use stateless mode instead of non-session mode here.
> 
>>> +\subsubsection{Feature bit requirements}\label{sec:Device Types / Crypto
>> Device / Feature bits}
>>> +
>>> +Some crypto feature bits require other crypto feature bits
>>> +(see \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}):
>>> +
>>> +\begin{description}
>>> +\item[VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE] Requires
>> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
>>> +\item[VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE] Requires
>> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
>>> +\item[VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE] Requires
>> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
>>> +\item[VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE] Requires
>> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
>>> +\end{description}
>>> +
>>> +\subsection{Device configuration layout}\label{sec:Device Types / Crypto
>> Device / Device configuration layout}
>>> +
>>> +The following driver-read-only configuration fields are defined:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_crypto_config {
>>> +    le32 status;
>>> +    le32 max_dataqueues;
>>> +    le32 crypto_services;
>>> +    /* Detailed algorithms mask */
>>> +    le32 cipher_algo_l;
>>> +    le32 cipher_algo_h;
>>> +    le32 hash_algo;
>>> +    le32 mac_algo_l;
>>> +    le32 mac_algo_h;
>>> +    le32 aead_algo;
>>> +    /* Maximum length of cipher key */
>>> +    le32 max_cipher_key_len;
>>> +    /* Maximum length of authenticated key */
>>> +    le32 max_auth_key_len;
>>> +    le32 reserved;
>>> +    /* Maximum size of each crypto request's content */
>>> +    le64 max_size;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or
>> ~VIRTIO_CRYPTO_S_HW_READY.
>>
>> Not entirely happy with this. What you want to say is reserved
>> for future use, or? Would it make sense to have a general note
>> -- in a similar fashion like for 'sizes are in bytes' -- for
>> reserved for future use?
>>
>> One possible formulation would be:
>>
>> "In this specification, unless explicitly stated otherwise,
>> fields and bits reserved for future use shall be zeroed out.
>> Both the a device or a driver device and the driver should
>> detect violations of this rule, and deny the requested
>> operation in an appropriate way if possible."
>>
>>
> Cornelia also provided a good suggestion about this. :)
> 

Yeah.

>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
>>> +\end{lstlisting}
>>> +
>>> +The VIRTIO_CRYPTO_S_HW_READY flag is used to show whether the
>> hardware is ready to work or not.
>>
>> I do not like hardware here.
>>
> Sorry about that, but it has existed in both Qemu and Linux driver. :(
> 

This is a spec, that's an implementation. You could theoretically use
different names, but I would not go that far. I would keep the constant
name but reword the sentence stating the semantic.

You seem to use "hardware", "accelerator", "backend", "hardware-backend",
"backend accelerator", "backend crypto accelerator(s)" interchangeably -- as
if these had the same meaning. Moreover I do not remember seeing a (precise)
definition for any of these phrases. Or am I wrong?

AFAIK, while avoiding word repetition (by using synonyms for example) is
considered good style in general, technical writing and especially
specifications are a prominent exception. In specifications consistent wording
should be preferred over avoiding repetition, and IMHO this is
especially important that the concepts of the domain under specification
are referred to in a consistent way (e.g. called always the same).

Do you agree? If you do, could we consolidate the virtio crypto spec
in this sense?

>>> +
>>> +The following driver-read-only fields include \field{max_dataqueues}, which
>> specifies the
>>
>> Why following?
>>
> Er, I used 'following' at here and there... It's just an auxiliary word.
> 

Well, I wanted to say 'following' and 'include' together make this
sentence look very strange to me.

AFAIU your answer 'following' is meant to be kind of ornamental here.
I also think we should drop any elements (words, sentences) having
purely ornamental function.

>>> +maximum number of data virtqueues (dataq1\ldots dataqN), and
>> \field{crypto_services},
>>> +which indicates the crypto services the virtio crypto supports.
>>> +
>>> +The following services are defined:
>>> +
>>> +\begin{lstlisting}
>>> +/* CIPHER service */
>>> +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
>>> +/* HASH service */
>>> +#define VIRTIO_CRYPTO_SERVICE_HASH   1
>>> +/* MAC (Message Authentication Codes) service */
>>> +#define VIRTIO_CRYPTO_SERVICE_MAC    2
>>> +/* AEAD (Authenticated Encryption with Associated Data) service */
>>> +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
>>> +\end{lstlisting}
>>> +
>>> +The last driver-read-only fields specify detailed algorithms masks
>>> +the device offers for corresponding services. The following CIPHER
>> algorithms
>>> +are defined:
>>
>> You do not establish an explicit relationship between the fields and the
>> macros for the flags. These are flags or? It seems quite common in the
>> spec to use _F_ in flag names. Would it be appropriate here?
>>
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CRYPTO_NO_CIPHER                 0
>>> +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
>>> +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
>>> +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
>>> +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
>>> +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
>>> +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
>>> +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
>>> +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
>>> +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
>>> +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
>>> +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
>>> +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
>>> +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
>>> +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
>>> +\end{lstlisting}
>>> +
>>> +The following HASH algorithms are defined:
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CRYPTO_NO_HASH            0
>>> +#define VIRTIO_CRYPTO_HASH_MD5           1
>>> +#define VIRTIO_CRYPTO_HASH_SHA1          2
>>> +#define VIRTIO_CRYPTO_HASH_SHA_224       3
>>> +#define VIRTIO_CRYPTO_HASH_SHA_256       4
>>> +#define VIRTIO_CRYPTO_HASH_SHA_384       5
>>> +#define VIRTIO_CRYPTO_HASH_SHA_512       6
>>> +#define VIRTIO_CRYPTO_HASH_SHA3_224      7
>>> +#define VIRTIO_CRYPTO_HASH_SHA3_256      8
>>> +#define VIRTIO_CRYPTO_HASH_SHA3_384      9
>>> +#define VIRTIO_CRYPTO_HASH_SHA3_512      10
>>> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
>>> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
>>> +\end{lstlisting}
>>> +
>>> +The following MAC algorithms are defined:
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CRYPTO_NO_MAC                       0
>>> +#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
>>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
>>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
>>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
>>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
>>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
>>> +#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
>>> +#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
>>> +#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
>>> +#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
>>> +#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
>>> +#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
>>> +#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
>>> +#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
>>> +#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
>>> +#define VIRTIO_CRYPTO_MAC_ZUC_EIA3                 54
>>> +\end{lstlisting}
>>> +
>>> +The following AEAD algorithms are defined:
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CRYPTO_NO_AEAD     0
>>> +#define VIRTIO_CRYPTO_AEAD_GCM    1
>>> +#define VIRTIO_CRYPTO_AEAD_CCM    2
>>> +#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
>>> +\end{lstlisting}
>>> +
>>
>> Would it make sense to interleave the flag definition
>> with the struct virtio_crypto_config?
>>
>>> +\begin{note}
>>> +Any other values are reserved for future use.
>>
>> Are these flags or values? I do not think values is appropriate here.
>>
> Please refer to my reply in another thread.
> 

Will answer there.

>>> +\end{note}
>>> +
>>
>> Some fields are missing here. This is inconsistent. Either
>> you should describe all or none (here).
>>
> Ok, will add other fields.
> 

Thx.

>>> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types
>> / Crypto Device / Device configuration layout}
>>> +
>>> +\begin{itemize*}
>>> +\item The device MUST set \field{max_dataqueues} to between 1 and 65535
>> inclusive.
>>> +\item The device MUST set \field{status} based on the status of the
>> hardware-backed implementation.
>>
>> What is a hardware-backend?
>>
> I meant the cryptodev backend, cryptodev-builtin, cryptodev-vhost-user for example.
> 

See above. This was a rhetorical question. Many of my question
are rhetorical, and are meant to be a gentle indicator of 
concern -- in opposition to saying something is straight-out
incomprehensible or wrong. 

I understood what hardware-backend means because I'm familiar with your
Linux/QEMU implementation. Please keep in mind, this specification
should make clean-room implementations possible (I mean, with
no looking at the linux kernel, or qemu code or whatherver).

>>> +\item The device MUST accept and handle requests after \field{status} is set
>> to VIRTIO_CRYPTO_S_HW_READY.
>>
>> Shouldn't this be the other way around (if VIRTIO_CRYPTO_S_HW_READY

Sorry, of course I have meant if ~VIRTIO_CRYPTO_S_HW_READY then reject!

>> then reject). Is a not well formed request or a backend failure considered?
>> What does handle mean? What should happen if requests are submitted
>> before VIRTIO_CRYPTO_S_HW_READY is set?
>>
> The requests MUST not be transmitted before VIRTIO_CRYPTO_S_HW_READY is set.
> Which is stated by the driver requirements. Otherwise the requests will be dropped.

This ('Otherwise the requests will be dropped.') ain't specified or?
Should not we specify this? How exactly are they 'dropped'?

> 
> The handle means execute crypto operations.
> 

But things can fail, you have a status (VIRTIO_CRYPT_(ERR|NOTSUPP|BADMSG))
for that. If that happens, does the device violate this point?

Do (all) other virtio devices have a similar conformance statement on when
they 'MUST accept and handle' requests or packets? If not what do you think,
should they?

>>> +\item The device MUST set \field{crypto_services} based on the crypto
>> services the device offers.
>>> +\item The device MUST set detailed algorithms masks based on the
>> \field{crypto_services} field.
>>> +\item The device MUST set \field{max_size} to show the maximum size of
>> crypto request the device supports.
>>> +\item The device MUST set \field{max_cipher_key_len} to show the
>> maximum length of cipher key if the device supports CIPHER service.
>>> +\item The device MUST set \field{max_auth_key_len} to show the maximum
>> length of authenticated key if the device supports MAC service.
>>> +\end{itemize*}
>>> +
>>> +\drivernormative{\subsubsection}{Device configuration layout}{Device Types
>> / Crypto Device / Device configuration layout}
>>> +
>>> +\begin{itemize*}
>>> +\item The driver MUST read the ready \field{status} from the bottom bit of
>> status to check whether the hardware-backed
>>> +      implementation is ready or not, and the driver MUST reread it after
>> the device reset.
>>> +\item The driver MUST NOT transmit any packets to the device if the ready
>> \field{status} is not set.
>>> +\item The driver MUST read \field{max_dataqueues} field to discover the
>> number of data queues the device supports.
>>> +\item The driver MUST read \field{crypto_services} field to discover which
>> services the device is able to offer.
>>> +\item The driver MUST read the detailed algorithms fields based on
>> \field{crypto_services} field.
>>> +\item The driver SHOULD read \field{max_size} to discover the maximum
>> size of crypto request the device supports.
>>> +\item The driver SHOULD read \field{max_cipher_key_len} to discover the
>> maximum length of cipher key the device supports.
>>> +\item The driver SHOULD read \field{max_auth_key_len} to discover the
>> maximum length of authenticated key the device supports.
>>> +\end{itemize*}
>>> +
>>> +\subsection{Device Initialization}\label{sec:Device Types / Crypto Device /
>> Device Initialization}
>>> +
>>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types /
>> Crypto Device / Device Initialization}
>>> +
>>> +\begin{itemize*}
>>> +\item The driver MUST identify and initialize the control virtqueue.
>>
>> But does not have to identify and initialize any data virtqueues?
>>
> Good catch. Both controlq and dataq.
> 
>>> +\item The driver MUST read the supported crypto services from bits of
>> \field{crypto_services}.
>>> +\item The driver MUST read the supported algorithms based on
>> \field{crypto_services} field.
>>> +\end{itemize*}
>>> +
>>> +\devicenormative{\subsubsection}{Device Initialization}{Device Types /
>> Crypto Device / Device Initialization}
>>> +
>>> +\begin{itemize*}
>>> +\item The device MUST be configured with at least one accelerator which
>> executes backend crypto operations.
>>
>> What does configured mean here? Is this initialization requirement.
>>
> It means the virtio crypto device MUST attach cryptodev backend. 
> Yes, it's a requirement.

What happens if an implementation fails to fulfill this requirement?
What is the benefit of having this requirement?

> 
>>> +\item The device MUST write the \field{crypto_services} field based on the
>> capacities of the backend accelerator.
>>> +\end{itemize*}
>>> +
>>
>> How do 'Initialization' and 'Configuration Layout' requirements relate to
>> each-other.
>>
> Basically they do the same things. But 'configuration layout' can't state the
> specific time.
>
>>> +\subsection{Device Operation}\label{sec:Device Types / Crypto Device /
>> Device Operation}
>>> +
>>> +Packets can be transmitted by placing them in both the controlq and dataq.
>>> +Packets consist of a general header and a service-specific request.
>>
>> Are packets and requests synonyms?
>>
> Yes, they are in virtio crypto spec.
> 

See above regarding consistent naming.

>>> +Where 'general header' is for all crypto requests, and 'service specific
>> requests'
>>
>> From below it seems you have two types of 'general header', but up until this
>> point it seems there is a single definition. Of course, this does not
>> really matter.
>>
> I distinguish it based on controlq and dataq in following statement.
> 

How about 'request header' or 'queue header'? Or something like 
'Packets consist of a queue-type specific header specifying among
others the operation, and an operation specific payload.'

I do not like 'general' here.

>>> +are composed of operation parameter + output data + input data in general.
>>> +Operation parameters are algorithm-specific parameters, output data is the
>>> +data that should be utilized in operations, and input data is equal to
>>> +"operation result + result data".
>>> +
>>> +The device can support both session mode (See \ref{sec:Device Types /
>> Crypto Device / Device Operation / Control Virtqueue / Session operation}) and
>> non-session mode, for example,
>>> +As VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE feature bit is
>> negotiated, the driver can use non-session mode for CIPHER service, otherwise
>> it can only use session mode.
>>
>> Grammar: Does not seem right to me. 'As' seems off and this could be two
>> sentences.
>>
> OK. Let me s/As/If the/ here.
> 

Capital won't do due to the 'for example, ' in the previous line.
Otherwise OK.

>>
>>> +
>>> +\begin{note}
>>> +The basic unit of all data length the byte.
>>> +\end{note}
>>> +
>>> +The general header for controlq is as follows:
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
>>> +
>>> +struct virtio_crypto_ctrl_header {
>>> +#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER,
>> 0x02)
>>> +#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER,
>> 0x03)
>>> +#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
>>> +#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
>>> +#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
>>> +#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
>>> +#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
>>> +#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
>>> +    le32 opcode;
>>> +    le32 algo;
>>> +    le32 flag;
>>> +    /* data virtqueue id */
>>> +    le32 queue_id;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The general header of dataq:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_crypto_op_header {
>>> +#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
>>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
>>> +#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
>>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
>>> +#define VIRTIO_CRYPTO_HASH \
>>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
>>> +#define VIRTIO_CRYPTO_MAC \
>>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
>>> +#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
>>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
>>> +#define VIRTIO_CRYPTO_AEAD_DECRYPT \
>>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
>>> +    le32 opcode;
>>> +    /* algo should be service-specific algorithms */
>>> +    le32 algo;
>>> +    /* session_id should be service-specific algorithms */
>>> +    le64 session_id;
>>> +#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
>>> +#define VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE 2
>>
>> Use _F_ istead of _FLAG_?
>>
> I'm afraid they are confused with the feature bits.
> 

Have a look at the desc flags (for example VIRTQ_DESC_F_INDIRECT).

It is your call in the end.

>>> +    /* control flag to control the request */
>>> +    le32 flag;
>>> +    le32 padding;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The device can set the operation status as follows: VIRTIO_CRYPTO_OK:
>> success;
>>> +VIRTIO_CRYPTO_ERR: failure or device error; VIRTIO_CRYPTO_NOTSUPP:
>> not supported;
>>> +VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto
>> operations.
>>> +
>>> +\begin{lstlisting}
>>> +enum VIRITO_CRYPTO_STATUS {
>>> +    VIRTIO_CRYPTO_OK = 0,
>>> +    VIRTIO_CRYPTO_ERR = 1,
>>> +    VIRTIO_CRYPTO_BADMSG = 2,
>>> +    VIRTIO_CRYPTO_NOTSUPP = 3,
>>> +    VIRTIO_CRYPTO_INVSESS = 4,
>>> +    VIRTIO_CRYPTO_MAX
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device /
>> Device Operation / Control Virtqueue}
>>> +
>>> +The driver uses the control virtqueue to send control commands to the
>>> +device which handles the non-data plane operations, such as session
>>
>> What is a 'non-data plane'?
>>
> I named controlling plane as the non-data plane. Maybe it's superfluous.
> 

Again consisten naming. I would prefer avoiding introducing this extra
name.

>>> +operations (See \ref{sec:Device Types / Crypto Device / Device Operation /
>> Control Virtqueue / Session operation}).
>>
>> Reviewed up until here. Depending on how things evolve will try to
>> review the rest too in the following days.
>>
> I knew it's a hard and time-consuming work to review such long spec.
> 
> Great thanks for your reviewing. :)
> 

I know, its annoying to deal with my comments ;). IMHO as spec
without a certain quantity of rigor is not really a spec. I think
it's very hard to write a good spec, so be patient.

>> A question and a remark as a closing word:
>> * Are there already some kernel and qemu patches for this 'non-session' stuff?
> 
> THB currently I have a patch for virtio_crypto.h. 
> 
> Attaching it for better review.
> 

I would prefer having an implementation of the new features on the list,
before voting on the spec itself.

>> * I think some proofreading (and eventually also touch-up) by a native speaker
>> would really benefit us. Sadly my grammar skills are very questionable, so
>> I can't help much. Nevertheless since it is a spec, I think we sould strive
>> for high standards in language usage too.
>>
> I agree and I actually asked a native speaker in my company to review it 
> several months ago. When all comments are handled, I'll do it again.

Thats cool.

Regards,
Halil

> 
> Thanks,
> -Gonglei
> 
