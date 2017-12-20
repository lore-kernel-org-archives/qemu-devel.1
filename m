Received: from eggs.gnu.org ([2001:4830:134:3::10]:51590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eRhU5-0005ws-Cw
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eRhU2-0007XM-DC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:44:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53350
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eRhU2-0007WX-3B
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:44:42 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBKGe5lm024721
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 11:44:39 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eyuc28r37-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 11:44:37 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Dec 2017 16:44:34 -0000
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 17:44:26 +0100
MIME-Version: 1.0
In-Reply-To: <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <db20b680-e7c8-6563-ebd7-27ab7e06ad6a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, Cornelia Huck <cohuck@redhat.com>, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

Meta: Updated Connie's email.

On 12/06/2017 08:37 AM, Longpeng(Mike) wrote:
> From: Gonglei <arei.gonglei@huawei.com>
> 
> The virtio crypto device is a virtual crypto device (ie. hardware
> crypto accelerator card). Currently, the virtio crypto device provides
> the following crypto services: CIPHER, MAC, HASH, and AEAD.
> 
> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
> 
> VIRTIO-153
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Zhoujian <jianjay.zhou@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  acknowledgements.tex |    4 +
>  content.tex          |    2 +
>  virtio-crypto.tex    | 1510 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1516 insertions(+)
>  create mode 100644 virtio-crypto.tex
> 
> diff --git a/acknowledgements.tex b/acknowledgements.tex
> index 2d893d9..cdde247 100644
> --- a/acknowledgements.tex
> +++ b/acknowledgements.tex
> @@ -16,10 +16,13 @@ Daniel Kiper,	Oracle	\newline
>  Geoff Brown,	Machine-to-Machine Intelligence (M2MI) Corporation	\newline
>  Gershon Janssen,	Individual Member	\newline
>  James Bottomley,	Parallels IP Holdings GmbH	\newline
> +Jian Zhou,	Huawei	\newline
> +Lei Gong,	Huawei	\newline
>  Luiz Capitulino,	Red Hat	\newline
>  Michael S. Tsirkin,	Red Hat	\newline
>  Paolo Bonzini,	Red Hat	\newline
>  Pawel Moll,	ARM \newline
> +Peng Long,	Huawei	\newline
>  Richard Sohn,	Alcatel-Lucent \newline
>  Rusty Russell,	IBM	\newline
>  Sasha Levin,	Oracle	\newline
> @@ -38,6 +41,7 @@ Brian Foley,  ARM \newline
>  David Alan Gilbert, Red Hat \newline
>  Fam Zheng, Red Hat	\newline
>  Gerd Hoffmann, Red Hat	\newline
> +Halil Pasic,	IBM	\newline
>  Jason Wang, Red Hat \newline
>  Laura Novich, Red Hat	\newline
>  Patrick Durusau,	Technical Advisory Board, OASIS	\newline
> diff --git a/content.tex b/content.tex
> index c840588..d1d3b09 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5819,6 +5819,8 @@ descriptor for the \field{sense_len}, \field{residual},
>  \field{status_qualifier}, \field{status}, \field{response} and
>  \field{sense} fields.
> 
> +\input{virtio-crypto.tex}
> +
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> 
>  Currently these device-independent feature bits defined:
> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
> new file mode 100644
> index 0000000..7e66898
> --- /dev/null
> +++ b/virtio-crypto.tex
> @@ -0,0 +1,1510 @@
> +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
> +
> +The virtio crypto device is a virtual cryptography device as well as a
> +virtual cryptographic accelerator. The virtio crypto device provides the
> +following crypto services: CIPHER, MAC, HASH, and AEAD. Virtio crypto
> +devices have a single control queue and at least one data queue. Crypto
> +operation requests are placed into a data queue, and serviced by the
> +device. Some crypto operation requests are only valid in the context of a
> +session. The role of the control queue is facilitating control operation
> +requests. Sessions management is realized with control operation
> +requests.
> +
> +\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device ID}
> +
> +20
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Crypto Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] dataq1
> +\item[\ldots]
> +\item[N-1] dataqN
> +\item[N] controlq
> +\end{description}
> +
> +N is set by \field{max_dataqueues}.
> +
> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature bits}
> +
> +\begin{description}
> +\item VIRTIO_CRYPTO_F_MUX_MODE (0) multiplexing mode is available.

Drop 'is available'? There is no separate frob for turning the MUX_MODE on/off
if it is available, or?

At this point it's pretty unclear what 'multiplexing mode' means. Furthermore
if you search the text for multiplexing, this is the only occurrence. 

I would probably go for"  

+\item VIRTIO_CRYPTO_F_MUX_MODE (0) multiplexing mode. Multiplexing mode
+ has a specific request format and other enhancements (which result in some
+ additional requirements).

> +\item VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE (1) stateless mode is available for CIPHER service.
> +\item VIRTIO_CRYPTO_F_HASH_STATELESS_MODE (2) stateless mode is available for HASH service.
> +\item VIRTIO_CRYPTO_F_MAC_STATELESS_MODE (3) stateless mode is available for MAC service.
> +\item VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE (4) stateless mode is available for AEAD service.
> +\end{description}
> +

I think this turned out quite complicated. First some observations I intend
to build on:

* I associate modes are mutual exclusiveness: e.g. a device is always
  in one of the several possible modes.
* In my understanding mixing stateful and stateless requests is possible
  (even on a same queue) iff the bit was negotiated for the service. I
  will use stateful here as the opposite of stateless and in a sense
  session bound.


In my opinion these stateless bits are supposed to be rather about
whether a certain type (stateless) of mux mode requests is supported by
the device.

What you actually do is the following. You define a
'VIRTIO_CRYPTO_F_<SERVICE_NAME>_STATELESS_MODE feature bit is negotiated'
(A) mode and a '... bit is not negotiated (B)' mode for each service. In
mode A the driver has to use type A sateful requests (to which you refer
as session mode).  In mode B however the driver can use both stateless
requests (to which you refer as stateless mode) and B type stateful
requests (to which you also refer as session mode).

The only difference between A type and B type stateful requests is, that for
B type, the VIRTIO_CRYPTO_FLAG_SESSION_MODE flag MUST be set. For A type
stateful requests however the specification does not seem to specify
definitive guidance on whether VIRTIO_CRYPTO_FLAG_SESSION_MODE is to be
set or not. From what I see the op_request flags are ignored in QEMU the
code.

I hope I managed to illustrate it's complicated. 

Can this be simplified? I think we could tie the obligation to set the
VIRTIO_CRYPTO_FLAG_SESSION_MODE or the VIRTIO_CRYPTO_FLAG_STATELESS_MODE
flag to MUX_MODE.

The point above would then morph to:


+\item VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE (4) stateless mode requests are supported by the AEAD service.

And then if VIRTIO_CRYPTO_F_MUX_MODE is negotiated but
VIRTIO_CRYPTO_F_<SERVICE>_STATELESS_MODE is not negotiated then <SERVICE>
requests with the VIRTIO_CRYPTO_FLAG_STATELESS_MODE flag set need to be
rejected. If VIRTIO_CRYPTO_F_MUX_MODE is negotiated is not negotiated the
flag bits VIRTIO_CRYPTO_FLAG_STATELESS_MODE and
VIRTIO_CRYPTO_FLAG_SESSION_MODE are ignored. We should probably ignore
op_reqest.flags altogether if MUX_MODE is not negotiated.

If we go down this path renaming VIRTIO_CRYPTO_F_MUX_MODE should be
considered.  We already have other stuff than the request format and with
that the stateless depending on this feature bit. I was thinking
something like _REVISION_1.

Note, this is not a show-stopper for me. While I do think what we have is
more complicated than it should be, it should still work. We can stick
with it. But if we do, we have to stick wit it till the end of days
(can't be improved later).


> +\subsubsection{Feature bit requirements}\label{sec:Device Types / Crypto Device / Feature bits}
> +
> +Some crypto feature bits require other crypto feature bits
> +(see \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}):
> +
> +\begin{description}
> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE. 
> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_MUX_MODE.
> +\end{description}
> +
> +\subsection{Supported crypto services}\label{sec:Device Types / Crypto Device / Supported crypto services}
> +
> +The following crypto services are defined:
> +
> +\begin{lstlisting}
> +/* CIPHER service */
> +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
> +/* HASH service */
> +#define VIRTIO_CRYPTO_SERVICE_HASH   1
> +/* MAC (Message Authentication Codes) service */
> +#define VIRTIO_CRYPTO_SERVICE_MAC    2
> +/* AEAD (Authenticated Encryption with Associated Data) service */
> +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
> +\end{lstlisting}
> +
> +The above constants designate bits used to indicate the which of crypto services are
> +offered by the device as described in, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
> +
> +\subsubsection{CIPHER services}\label{sec:Device Types / Crypto Device / Supported crypto services / CIPHER services}
> +
> +The following CIPHER algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_CIPHER                 0
> +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
> +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
> +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
> +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
> +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
> +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
> +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
> +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
> +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
> +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
> +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
> +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
> +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
> +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
> +\end{lstlisting}
> +
> +The above constants have two usages:
> +\begin{enumerate}
> +\item As bit numbers, used to tell the driver which CIPHER algorithms
> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
> +\item As values, used to designate the algorithm in (CIPHER type) crypto
> +operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
> +\end{enumerate}
> +
> +\subsubsection{HASH services}\label{sec:Device Types / Crypto Device / Supported crypto services / HASH services}
> +
> +The following HASH algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_HASH            0
> +#define VIRTIO_CRYPTO_HASH_MD5           1
> +#define VIRTIO_CRYPTO_HASH_SHA1          2
> +#define VIRTIO_CRYPTO_HASH_SHA_224       3
> +#define VIRTIO_CRYPTO_HASH_SHA_256       4
> +#define VIRTIO_CRYPTO_HASH_SHA_384       5
> +#define VIRTIO_CRYPTO_HASH_SHA_512       6
> +#define VIRTIO_CRYPTO_HASH_SHA3_224      7
> +#define VIRTIO_CRYPTO_HASH_SHA3_256      8
> +#define VIRTIO_CRYPTO_HASH_SHA3_384      9
> +#define VIRTIO_CRYPTO_HASH_SHA3_512      10
> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
> +\end{lstlisting}
> +
> +The above constants have two usages:
> +\begin{enumerate}
> +\item As bit numbers, used to tell the driver which HASH algorithms
> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
> +\item As values, used to designate the algorithm in (HASH type) crypto
> +operation requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
> +\end{enumerate}
> +
> +\subsubsection{MAC services}\label{sec:Device Types / Crypto Device / Supported crypto services / MAC services}
> +
> +The following MAC algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_MAC                       0
> +#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
> +#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
> +#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
> +#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
> +#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
> +#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
> +#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
> +#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
> +#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
> +#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
> +#define VIRTIO_CRYPTO_MAC_ZUC_EIA3                 54
> +\end{lstlisting}
> +
> +The above constants have two usages:
> +\begin{enumerate}
> +\item As bit numbers, used to tell the driver which MAC algorithms
> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
> +\item As values, used to designate the algorithm in (MAC type) crypto
> +operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
> +\end{enumerate}
> +
> +\subsubsection{AEAD services}\label{sec:Device Types / Crypto Device / Supported crypto services / AEAD services}
> +
> +The following AEAD algorithms are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_NO_AEAD     0
> +#define VIRTIO_CRYPTO_AEAD_GCM    1
> +#define VIRTIO_CRYPTO_AEAD_CCM    2
> +#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
> +\end{lstlisting}
> +
> +The above constants have two usages:
> +\begin{enumerate}
> +\item As bit numbers, used to tell the driver which AEAD algorithms
> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
> +\item As values, used to designate the algorithm in (DEAD type) crypto
> +operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
> +\end{enumerate}
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / Crypto Device / Device configuration layout}
> +
> +\begin{lstlisting}
> +struct virtio_crypto_config {
> +    le32 status;
> +    le32 max_dataqueues;
> +    le32 crypto_services;
> +    /* Detailed algorithms mask */
> +    le32 cipher_algo_l;
> +    le32 cipher_algo_h;
> +    le32 hash_algo;
> +    le32 mac_algo_l;
> +    le32 mac_algo_h;
> +    le32 aead_algo;
> +    /* Maximum length of cipher key in bytes */
> +    le32 max_cipher_key_len;
> +    /* Maximum length of authenticated key in bytes */
> +    le32 max_auth_key_len;
> +    le32 reserved;
> +    /* Maximum size of each crypto request's content in bytes */
> +    le64 max_size;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item Currently, only one \field(status) bit is defined: VIRTIO_CRYPTO_S_HW_READY
> +    set indicates that the device is ready to process requests, this bit is read-only
> +    for the driver
> +\begin{lstlisting}
> +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
> +\end{lstlisting}
> +
> +\item[\field{max_dataqueues}] is the maximum number of data virtqueues that can
> +    be configured by the device. The driver MAY use only one data queue, or it
> +    can use more to achieve better performance.
> +
> +\item[\field{crypto_services}] crypto service offered, see \ref{sec:Device Types / Crypto Device / Supported crypto services}.
> +
> +\item[\field{cipher_algo_l}] CIPHER algorithms bits 0-31, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
> +
> +\item[\field{cipher_algo_h}] CIPHER algorithms bits 32-63, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
> +
> +\item[\field{hash_algo}] HASH algorithms bits, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / HASH services}.
> +
> +\item[\field{mac_algo_l}] MAC algorithms bits 0-31, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
> +
> +\item[\field{mac_algo_h}] MAC algorithms bits 32-63, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
> +
> +\item[\field{aead_algo}] AEAD algorithms bits, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / AEAD services}.
> +
> +\item[\field{max_cipher_key_len}] is the maximum length of cipher key supported by the device.
> +
> +\item[\field{max_auth_key_len}] is the maximum length of authenticated key supported by the device.
> +
> +\item[\field{reserved}] is reserved for future use.
> +
> +\item[\field{max_size}] is the maximum size of each crypto request's content supported by the device
> +\end{description}
> +
> +\begin{note}
> +Unless explicitly stated otherwise all lengths and sizes are in bytes.
> +\end{note}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
> +
> +\begin{itemize*}
> +\item The device MUST set \field{max_dataqueues} to between 1 and 65535 inclusive.
> +\item The device MUST set the \field{status} with valid flags, undefined flags MUST NOT be set.
> +\item The device MUST accept and handle requests after \field{status} is set to VIRTIO_CRYPTO_S_HW_READY.
> +\item The device MUST set \field{crypto_services} based on the crypto services the device offers.
> +\item The device MUST set detailed algorithms masks for each service advertised by \field{crypto_services}.
> +    The device MUST NOT set the not defined algorithms bits.
> +\item The device MUST set \field{max_size} to show the maximum size of crypto request the device supports.
> +\item The device MUST set \field{max_cipher_key_len} to show the maximum length of cipher key if the
> +    device supports CIPHER service.
> +\item The device MUST set \field{max_auth_key_len} to show the maximum length of authenticated key if
> +    the device supports MAC service.
> +\end{itemize*}
> +
> +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
> +
> +\begin{itemize*}
> +\item The driver MUST read the \field{status} from the bottom bit of status to check whether the
> +    VIRTIO_CRYPTO_S_HW_READY is set, and the driver MUST reread it after device reset.
> +\item The driver MUST NOT transmit any requests to the device if the VIRTIO_CRYPTO_S_HW_READY is not set.
> +\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.
> +\item The driver MUST read \field{crypto_services} field to discover which services the device is able to offer.
> +\item The driver SHOULD ignore the not defined algorithms bits.
> +\item The driver MUST read the detailed algorithms fields based on \field{crypto_services} field.
> +\item The driver SHOULD read \field{max_size} to discover the maximum size of crypto request the device supports.
> +\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key
> +    the device supports.
> +\item The driver SHOULD read \field{max_auth_key_len} to discover the maximum length of authenticated
> +    key the device supports.
> +\end{itemize*}
> +
> +\subsection{Device Initialization}\label{sec:Device Types / Crypto Device / Device Initialization}
> +
> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / Crypto Device / Device Initialization}
> +
> +\begin{itemize*}
> +\item The driver MUST configure and initialize all virtqueues.
> +\item The driver MUST read the supported crypto services from bits of \field{crypto_services}.
> +\item The driver MUST read the supported algorithms based on \field{crypto_services} field.
> +\end{itemize*}
> +
> +\subsection{Device Operation}\label{sec:Device Types / Crypto Device / Device Operation}
> +
> +The operation of a virtio crypto device is driven by requests placed on the virtqueues.
> +Requests consist of a queue-type specific header (specifying among others the operation)
> +and an operation specific payload.
> +
> +If VIRTIO_CRYPTO_F_MUX_MODE is negotiated the device may support both session mode
> +(See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation})
> +and stateless mode operation requests.
> +In stateless mode all operation parameters are supplied as a part of each request,
> +while in session mode, some or all operation parameters are managed within the
> +session. Stateless mode is guarded by feature bits 0-4 on a service level. If
> +stateless mode is negotiated for a service, the service is available both in
> +session and stateless mode; otherwise it's only available in session mode.
> +
> +\subsubsection{Operation Status}\label{sec:Device Types / Crypto Device / Device Operation / Operation status}
> +The device MUST return a status code as part of the operation (both session
> +operation and service operation) result. The valid operation status as follows:
> +
> +\begin{lstlisting}
> +enum VIRTIO_CRYPTO_STATUS {
> +    VIRTIO_CRYPTO_OK = 0,
> +    VIRTIO_CRYPTO_ERR = 1,
> +    VIRTIO_CRYPTO_BADMSG = 2,
> +    VIRTIO_CRYPTO_NOTSUPP = 3,
> +    VIRTIO_CRYPTO_INVSESS = 4,
> +    VIRTIO_CRYPTO_NOSPC = 5,
> +    VIRTIO_CRYPTO_MAX
> +};
> +\end{lstlisting}
> +
> +\begin{itemize*}
> +\item VIRTIO_CRYPTO_OK: success.
> +\item VIRTIO_CRYPTO_BADMSG: authentication failed (only when AEAD decryption).
> +\item VIRTIO_CRYPTO_NOTSUPP: operation or algorithm is unsupported.
> +\item VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto operations.
> +\item VIRTIO_CRYPTO_NOSPC: no free session ID (only when the VIRTIO_CRYPTO_F_MUX_MODE
> +    feature bit is negotiated).
> +\item VIRTIO_CRYPTO_ERR: any failure not mentioned above occurs.
> +\end{itemize*}
> +
> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}

We have already discussed the control virtqueue part so I'm going to
skip it.

Except for the stuff I'm complaining about above it looks good to me.

Regards,
Halil
