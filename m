Received: from eggs.gnu.org ([2001:4830:134:3::10]:39211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAJOW-00087E-O8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAJOS-0001j4-E2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:02:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dAJOR-0001ih-S5
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:02:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4FGi3kg130484
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:02:46 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2affx718f7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:02:45 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 15 May 2017 18:02:40 +0100
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<1e56f82e-6afb-af30-acb9-6f66373c7bc2@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 15 May 2017 19:02:31 +0200
MIME-Version: 1.0
In-Reply-To: <1e56f82e-6afb-af30-acb9-6f66373c7bc2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <4da0a8ec-14bf-20bd-9a15-3a83211fed7b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v18 1/2] virtio-crypto:
 Add virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, arei.gonglei@hotmail.com, linqiangmin@huawei.com, zhbzg@huawei.com, eety.chen@huawei.com, amy.zhanghuimin@huawei.com, lixiao91@huawei.com



On 05/10/2017 08:02 PM, Halil Pasic wrote:
> 
> 
> On 04/22/2017 08:23 AM, Gonglei wrote:
>> The virtio crypto device is a virtual crypto device (ie. hardware
>> crypto accelerator card). Currently, the virtio crypto device provides
>> the following crypto services: CIPHER, MAC, HASH, and AEAD.
>>
>> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
>>
>> VIRTIO-153
>>
>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Lingli Deng <denglingli@chinamobile.com>
>> CC: Jani Kokkonen <Jani.Kokkonen@huawei.com>
>> CC: Ola Liljedahl <Ola.Liljedahl@arm.com>
>> CC: Varun Sethi <Varun.Sethi@freescale.com>
>> CC: Zeng Xin <xin.zeng@intel.com>
>> CC: Keating Brian <brian.a.keating@intel.com>
>> CC: Ma Liang J <liang.j.ma@intel.com>
>> CC: Griffin John <john.griffin@intel.com>
>> CC: Mihai Claudiu Caraman <mike.caraman@nxp.com>
>> CC: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  acknowledgements.tex |    2 +
>>  content.tex          |    2 +
>>  virtio-crypto.tex    | 1309 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1313 insertions(+)
>>  create mode 100644 virtio-crypto.tex
>>
>> diff --git a/acknowledgements.tex b/acknowledgements.tex
>> index 53942b0..43b8a9b 100644
>> --- a/acknowledgements.tex
>> +++ b/acknowledgements.tex
>> @@ -26,6 +26,7 @@ Sasha Levin,	Oracle	\newline
>>  Sergey Tverdyshev,	Thales e-Security	\newline
>>  Stefan Hajnoczi,	Red Hat	\newline
>>  Tom Lyon,	Samya Systems, Inc.	\newline
>> +Lei Gong,  Huawei   \newline
>>  \end{oasistitlesection}
>>
>>  The following non-members have provided valuable feedback on this
>> @@ -44,4 +45,5 @@ Patrick Durusau,	Technical Advisory Board, OASIS	\newline
>>  Thomas Huth,	Red Hat	\newline
>>  Yan Vugenfirer, Red Hat / Daynix	\newline
>>  Kevin Lo,	MSI	\newline
>> +Halil Pasic, IBM  \newline
>>  \end{oasistitlesection}
>> diff --git a/content.tex b/content.tex
>> index 4b45678..ab75f78 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -5750,6 +5750,8 @@ descriptor for the \field{sense_len}, \field{residual},
>>  \field{status_qualifier}, \field{status}, \field{response} and
>>  \field{sense} fields.
>>
>> +\input{virtio-crypto.tex}
>> +
>>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>
>>  Currently there are three device-independent feature bits defined:
>> diff --git a/virtio-crypto.tex b/virtio-crypto.tex
>> new file mode 100644
>> index 0000000..2708023
>> --- /dev/null
>> +++ b/virtio-crypto.tex
>> @@ -0,0 +1,1309 @@
>> +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
>> +
>> +The virtio crypto device is a virtual cryptography device as well as a kind of
>> +virtual hardware accelerator for virtual machines. The encryption and
>> +decryption requests are placed in any of the data queues and are ultimately handled by the
>> +backend crypto accelerators. The second kind of queue is the control queue used to create 
>> +or destroy sessions for symmetric algorithms and will control some advanced
>> +features in the future. The virtio crypto device provides the following crypto
>> +services: CIPHER, MAC, HASH, and AEAD.
>> +
>> +
>> +\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device ID}
>> +
>> +20
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / Crypto Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] dataq1
>> +\item[\ldots]
>> +\item[N-1] dataqN
>> +\item[N] controlq
>> +\end{description}
>> +
>> +N is set by \field{max_dataqueues}.
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature bits}
>> +
>> +VIRTIO_CRYPTO_F_STATELESS_MODE (0) stateless mode is available.
>> +VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE (1) stateless mode is available for CIPHER service.
>> +VIRTIO_CRYPTO_F_HASH_STATELESS_MODE (2) stateless mode is available for HASH service.
>> +VIRTIO_CRYPTO_F_MAC_STATELESS_MODE (3) stateless mode is available for MAC service.
>> +VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE (4) stateless mode is available for AEAD service.
>> +
>> +\subsubsection{Feature bit requirements}\label{sec:Device Types / Crypto Device / Feature bits}
>> +
>> +Some crypto feature bits require other crypto feature bits
>> +(see \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}):
>> +
>> +\begin{description}
>> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_STATELESS_MODE.
>> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_STATELESS_MODE.
>> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_STATELESS_MODE.
>> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires VIRTIO_CRYPTO_F_STATELESS_MODE.
>> +\end{description}
>> +
>> +\subsection{Supported crypto services}\label{sec:Device Types / Crypto Device / Supported crypto services}
>> +
>> +The virtio crypto device provides the following crypto services: CIPHER, MAC, HASH, and AEAD.
>> +
>> +\begin{lstlisting}
>> +/* CIPHER service */
>> +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
>> +/* HASH service */
>> +#define VIRTIO_CRYPTO_SERVICE_HASH   1
>> +/* MAC (Message Authentication Codes) service */
>> +#define VIRTIO_CRYPTO_SERVICE_MAC    2
>> +/* AEAD (Authenticated Encryption with Associated Data) service */
>> +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
>> +\end{lstlisting}
>> +
>> +The above constants are bit numbers, which tell the driver which crypto services
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +
>> +\subsubsection{CIPHER services}\label{sec:Device Types / Crypto Device / Supported crypto services / CIPHER services}
>> +
>> +The following CIPHER algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_CIPHER                 0
>> +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
>> +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
>> +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
>> +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
>> +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
>> +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
>> +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
>> +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
>> +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
>> +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
>> +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
>> +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
>> +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
>> +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which CIPHER algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to tell the device which CIPHER algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsubsection{HASH services}\label{sec:Device Types / Crypto Device / Supported crypto services / HASH services}
>> +
>> +The following HASH algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_HASH            0
>> +#define VIRTIO_CRYPTO_HASH_MD5           1
>> +#define VIRTIO_CRYPTO_HASH_SHA1          2
>> +#define VIRTIO_CRYPTO_HASH_SHA_224       3
>> +#define VIRTIO_CRYPTO_HASH_SHA_256       4
>> +#define VIRTIO_CRYPTO_HASH_SHA_384       5
>> +#define VIRTIO_CRYPTO_HASH_SHA_512       6
>> +#define VIRTIO_CRYPTO_HASH_SHA3_224      7
>> +#define VIRTIO_CRYPTO_HASH_SHA3_256      8
>> +#define VIRTIO_CRYPTO_HASH_SHA3_384      9
>> +#define VIRTIO_CRYPTO_HASH_SHA3_512      10
>> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
>> +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which HASH algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to tell the device which HASH algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsubsection{MAC services}\label{sec:Device Types / Crypto Device / Supported crypto services / MAC services}
>> +
>> +The following MAC algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_MAC                       0
>> +#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
>> +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
>> +#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
>> +#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
>> +#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
>> +#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
>> +#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
>> +#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
>> +#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
>> +#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
>> +#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
>> +#define VIRTIO_CRYPTO_MAC_ZUC_EIA3                 54
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which MAC algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to tell the device which MAC algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsubsection{AEAD services}\label{sec:Device Types / Crypto Device / Supported crypto services / AEAD services}
>> +
>> +The following AEAD algorithms are defined:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_NO_AEAD     0
>> +#define VIRTIO_CRYPTO_AEAD_GCM    1
>> +#define VIRTIO_CRYPTO_AEAD_CCM    2
>> +#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
>> +\end{lstlisting}
>> +
>> +The above constants have two usages:
>> +\begin{enumerate}
>> +\item As bit numbers, used to tell the driver which AEAD algorithms
>> +are supported by the device, see \ref{sec:Device Types / Crypto Device / Device configuration layout}.
>> +\item As values, used to tell the device what AEAD algorithm
>> +a crypto request from the driver requires, see \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}.
>> +\end{enumerate}
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / Crypto Device / Device configuration layout}
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_config {
>> +    le32 status;
>> +    le32 max_dataqueues;
>> +    le32 crypto_services;
>> +    /* Detailed algorithms mask */
>> +    le32 cipher_algo_l;
>> +    le32 cipher_algo_h;
>> +    le32 hash_algo;
>> +    le32 mac_algo_l;
>> +    le32 mac_algo_h;
>> +    le32 aead_algo;
>> +    /* Maximum length of cipher key in bytes */
>> +    le32 max_cipher_key_len;
>> +    /* Maximum length of authenticated key in bytes */
>> +    le32 max_auth_key_len;
>> +    le32 reserved;
>> +    /* Maximum size of each crypto request's content in bytes */
>> +    le64 max_size;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{description}
>> +\item[\field{status}] is used to show whether the device is ready to work or not, it can be either zero or have one or more flags
>> +    Only one read-only bit (for the driver) is currently defined for the \field{status} field: VIRTIO_CRYPTO_S_HW_READY:
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
>> +\end{lstlisting}
>> +
>> +\item[\field{max_dataqueues}] is the maximum number of data virtqueues exposed by
>> +    the device. The driver MAY use only one data queue,
>> +    or it can use more to achieve better performance.
>> +
>> +\item[\field{crypto_services}] is a 32-bit mask which indicates the crypto services supported by
>> +    the device, see \ref{sec:Device Types / Crypto Device / Supported crypto services}.
>> +
>> +\item[\field{cipher_algo_l}] is the low 32-bit mask which indicates the CIPHER algorithms supported by
>> +    the device, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
>> +
>> +\item[\field{cipher_algo_h}] is the high 32-bit mask which indicates the CIPHER algorithms supported by
>> +    the device, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / CIPHER services}.
>> +
>> +\item[\field{hash_algo}] is a 32-bit mask which indicates the HASH algorithms supported by
>> +    the device, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / HASH services}.
>> +
>> +\item[\field{mac_algo_l}] is the low 32-bit mask which indicates the MAC algorithms supported by
>> +    the device, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
>> +
>> +\item[\field{mac_algo_h}] is the high 32-bit mask which indicates the MAC algorithms supported by
>> +    the device, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / MAC services}.
>> +
>> +\item[\field{aead_algo}] is a 32-bit mask which indicates the AEAD algorithms supported by
>> +    the device, see \ref{sec:Device Types / Crypto Device / Supported crypto services  / AEAD services}.
>> +
>> +\item[\field{max_cipher_key_len}] is the maximum length of cipher key supported by the device.
>> +
>> +\item[\field{max_auth_key_len}] is the maximum length of authenticated key supported by the device.
>> +
>> +\item[\field{reserved}] is reserved for future use.
>> +
>> +\item[\field{max_size}] is the maximum size of each crypto request's content supported by the device
>> +\end{description}
>> +
>> +\begin{note}
>> +Unless explicitly stated otherwise all lengths and sizes are in bytes.
>> +\end{note}
>> +
>> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
>> +
>> +\begin{itemize*}
>> +\item The device MUST set \field{max_dataqueues} to between 1 and 65535 inclusive.
>> +\item The device MUST set \field{status} based on the status of the backend crypto accelerator. 
>> +\item The device MUST accept and handle requests after \field{status} is set to VIRTIO_CRYPTO_S_HW_READY.
>> +\item The device MUST set \field{crypto_services} based on the crypto services the device offers.
>> +\item The device MUST set detailed algorithms masks based on the \field{crypto_services} field.
>> +\item The device MUST set \field{max_size} to show the maximum size of crypto request the device supports.
>> +\item The device MUST set \field{max_cipher_key_len} to show the maximum length of cipher key if the device supports CIPHER service.
>> +\item The device MUST set \field{max_auth_key_len} to show the maximum length of authenticated key if the device supports MAC service.
>> +\end{itemize*}
>> +
>> +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Crypto Device / Device configuration layout}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST read the ready \field{status} from the bottom bit of status to check whether the backend crypto accelerator
>> +      is ready or not, and the driver MUST reread it after device reset. 
>> +\item The driver MUST NOT transmit any requests to the device if the ready \field{status} is not set.
>> +\item The driver MUST read \field{max_dataqueues} field to discover the number of data queues the device supports.
>> +\item The driver MUST read \field{crypto_services} field to discover which services the device is able to offer.
>> +\item The driver MUST read the detailed algorithms fields based on \field{crypto_services} field.
>> +\item The driver SHOULD read \field{max_size} to discover the maximum size of crypto request the device supports.
>> +\item The driver SHOULD read \field{max_cipher_key_len} to discover the maximum length of cipher key the device supports.
>> +\item The driver SHOULD read \field{max_auth_key_len} to discover the maximum length of authenticated key the device supports.
>> +\end{itemize*}
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / Crypto Device / Device Initialization}
>> +
>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / Crypto Device / Device Initialization}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST identify and initialize all virtqueues.
>> +\item The driver MUST read the supported crypto services from bits of \field{crypto_services}. 
>> +\item The driver MUST read the supported algorithms based on \field{crypto_services} field.
>> +\end{itemize*}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / Crypto Device / Device Operation}
>> +
>> +Requests can be transmitted by placing them in the controlq or dataq.
>> +Requests consist of a queue-type specific header specifying among
>> +others the operation, and an operation specific payload.
>> +The payload is generally composed of operation parameters, output data, and input data.
>> +Operation parameters are algorithm-specific parameters, output data is the
>> +data that should be utilized in operations, and input data is equal to
>> +"operation result + result data".
>> +
>> +The device can support both session mode (See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}) and stateless mode.
>> +If VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE is negotiated, the driver can use stateless mode for CIPHER service, otherwise it can only use session mode.
>> +
>> +The header for controlq is as follows:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
>> +
>> +struct virtio_crypto_ctrl_header {
>> +#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
>> +#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
>> +#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
>> +#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
>> +#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
>> +#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
>> +#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
>> +#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
>> +    le32 opcode;
>> +    /* algo should be service-specific algorithms */
>> +    le32 algo;
>> +    le32 flag;
>> +    /* data virtqueue id */
>> +    le32 queue_id;
>> +};
>> +\end{lstlisting}
>> +
>> +The header for dataq is as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_header {
>> +#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
>> +#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
>> +#define VIRTIO_CRYPTO_HASH \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
>> +#define VIRTIO_CRYPTO_MAC \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
>> +#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
>> +#define VIRTIO_CRYPTO_AEAD_DECRYPT \
>> +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
>> +    le32 opcode;
>> +    /* algo should be service-specific algorithms */
>> +    le32 algo;
>> +    le64 session_id;
>> +#define VIRTIO_CRYPTO_FLAG_STATE_MODE 1
>> +#define VIRTIO_CRYPTO_FLAG_STATELESS_MODE 2
>> +    /* control flag to control the request */
>> +    le32 flag;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
> 
> START HERE
> 
>> +The device can set the operation status as follows: VIRTIO_CRYPTO_OK: success;
>> +VIRTIO_CRYPTO_ERR: failure or device error; VIRTIO_CRYPTO_NOTSUPP: not supported;
>> +VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto operations.
> 
> You describe everything but BADMSG. Could you be a bit more specific
> about the differences between _ERR _BADMSG and _NOTSUPP? Is for instance trying
> to do something with a not-advertised service or algo a _NOTSUPP or a
> _BADMSG or just a generic _ERR? Same qestion goes for different sorts of
> out of resources. 
> 
>> +
>> +\begin{lstlisting}
>> +enum VIRTIO_CRYPTO_STATUS {
>> +    VIRTIO_CRYPTO_OK = 0,
>> +    VIRTIO_CRYPTO_ERR = 1,
>> +    VIRTIO_CRYPTO_BADMSG = 2,
>> +    VIRTIO_CRYPTO_NOTSUPP = 3,
>> +    VIRTIO_CRYPTO_INVSESS = 4,
>> +    VIRTIO_CRYPTO_MAX
>> +};
>> +\end{lstlisting}
>> +
> 
> There are no more mentions of the values in the spec, so the description
> above should be real good.
> 
>> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}
>> +
>> +The driver uses the control virtqueue to send control commands to the
>> +device, such as session operations (See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}).
>> +
>> +Controlq requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_ctrl_req {
>> +    struct virtio_crypto_ctrl_header header;
>> +
>> +    union {
>> +        struct virtio_crypto_sym_create_session_req   sym_create_session;
>> +        struct virtio_crypto_hash_create_session_req  hash_create_session;
>> +        struct virtio_crypto_mac_create_session_req   mac_create_session;
>> +        struct virtio_crypto_aead_create_session_req  aead_create_session;
>> +        struct virtio_crypto_destroy_session_req      destroy_session;
>> +    } u;
>> +};
>> +\end{lstlisting}
>> +
>> +struct virtio_crypto_op_ctrl_req is the only allowed control request.
>> +The header is the general header, and the union is of the algorithm-specific type,
>> +which is set by the driver. All the properties in the union are shown as follows.
>> +
>> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}
>> +
>> +The symmetric algorithms involve the concept of sessions. A session is a
>> +handle which describes the cryptographic parameters to be applied to
>> +a number of buffers. 
> 
> 8<
>> The data within a session handle includes:
>> +
>> +\begin{enumerate}
>> +\item The operation (CIPHER, HASH/MAC or both, and if both, the order in
>> +      which the algorithms should be applied).
>> +\item The CIPHER set data, including the CIPHER algorithm and mode,
>> +      the key and its length, and the direction (encryption or decryption).
>> +\item The HASH/MAC set data, including the HASH algorithm or MAC algorithm,
>> +      and hash result length (to allow for truncation).
>> +\begin{itemize*}
>> +\item Authenticated mode can refer to MAC, which requires that the key and
>> +      its length are also specified.
>> +\item For nested mode, the inner and outer prefix data and length are specified,
>> +      as well as the outer HASH algorithm.
>> +\end{itemize*}
>> +\end{enumerate}
>> +
>> 8
> 
> This part is slightly confusing for me. I guess you are trying to describe
> what data can live in the session context (considering all the different
> applications). I think we do not have to describe that here, because we have
> to describe the individual session operations, and there we must describe
> the precise impact of these operations (and their parameters).
> 
>> +The following structure stores the result of session creation set by the device:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_session_input {
>> +    /* Device-writable part */
>> +    le64 session_id;
>> +    le32 status;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +A request to destroy a session includes the following information:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_destroy_session_req {
>> +    /* Device-readable part */
>> +    le64  session_id;
>> +    /* Device-writable part */
>> +    le32  status;
>> +    le32  padding;
>> +};
>> +\end{lstlisting}
>> +
>> +\subparagraph{Session operation: HASH session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: HASH session}
>> +
>> +HASH session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_hash_session_para {
>> +    /* See VIRTIO_CRYPTO_HASH_* above */
>> +    le32 algo;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +};
>> +struct virtio_crypto_hash_create_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_hash_session_para para;
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +\subparagraph{Session operation: MAC session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: MAC session}
>> +
>> +MAC session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_mac_session_para {
>> +    /* See VIRTIO_CRYPTO_MAC_* above */
>> +    le32 algo;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +    /* length of authenticated key */
>> +    le32 auth_key_len;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_mac_create_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_mac_session_para para;
>> +    /* The authenticated key */
>> +    u8 auth_key[auth_key_len];
>> +
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +\subparagraph{Session operation: Symmetric algorithms session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: Symmetric algorithms session}
>> +
>> +The request of symmetric session includes two parts, CIPHER algorithms and chain
>> +algorithms (chaining CIPHER and HASH/MAC). 
>> +
>> +CIPHER session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_cipher_session_para {
>> +    /* See VIRTIO_CRYPTO_CIPHER* above */
>> +    le32 algo;
>> +    /* length of key */
>> +    le32 keylen;
>> +#define VIRTIO_CRYPTO_OP_ENCRYPT  1
>> +#define VIRTIO_CRYPTO_OP_DECRYPT  2
>> +    /* encryption or decryption */
>> +    le32 op;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_cipher_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_cipher_session_para para;
>> +    /* The cipher key */
>> +    u8 cipher_key[keylen];
>> +
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +Algorithm chaining requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_alg_chain_session_para {
>> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
>> +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
>> +    le32 alg_chain_order;
>> +/* Plain hash */
>> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
>> +/* Authenticated hash (mac) */
>> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
>> +/* Nested hash */
>> +#define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
>> +    le32 hash_mode;
>> +    struct virtio_crypto_cipher_session_para cipher_param;
>> +    union {
>> +        struct virtio_crypto_hash_session_para hash_param;
>> +        struct virtio_crypto_mac_session_para mac_param;
>> +    } u;
>> +    /* length of the additional authenticated data (AAD) in bytes */
>> +    le32 aad_len;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_alg_chain_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_alg_chain_session_para para;
>> +    /* The cipher key */
>> +    u8 cipher_key[keylen];
>> +    /* The authenticated key */
>> +    u8 auth_key[auth_key_len];
>> +
>> +    /* Device-writable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +Symmetric algorithm requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_sym_create_session_req {
>> +    union {
>> +        struct virtio_crypto_cipher_session_req cipher;
>> +        struct virtio_crypto_alg_chain_session_req chain;
>> +    } u;
>> +
>> +    /* Device-readable part */
>> +
>> +/* No operation */
>> +#define VIRTIO_CRYPTO_SYM_OP_NONE  0
>> +/* Cipher only operation on the data */
>> +#define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
>> +/* Chain any cipher with any hash or mac operation. The order
>> +   depends on the value of alg_chain_order param */
>> +#define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
>> +    le32 op_type;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +The driver can set the \field{op_type} field in struct virtio_crypto_sym_create_session_req as follows: VIRTIO_CRYPTO_SYM_OP_NONE: no operation;
>> +VIRTIO_CRYPTO_SYM_OP_CIPHER: Cipher only operation on the data; VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING: Chain any cipher with any hash or mac operation.
>> +
>> +\subparagraph{Session operation: AEAD session}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: AEAD session}
>> +
>> +AEAD session requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_aead_session_para {
>> +    /* See VIRTIO_CRYPTO_AEAD_* above */
>> +    le32 algo;
>> +    /* length of key */
>> +    le32 key_len;
>> +    /* Authentication tag length */
>> +    le32 tag_len;
>> +    /* The length of the additional authenticated data (AAD) in bytes */
>> +    le32 aad_len;
>> +    /* encryption or decryption, See above VIRTIO_CRYPTO_OP_* */
>> +    le32 op;
>> +    le32 padding;
>> +};
>> +
>> +struct virtio_crypto_aead_create_session_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_aead_session_para para;
>> +    u8 key[key_len];
>> +
>> +    /* Device-writeable part */
>> +    struct virtio_crypto_session_input input;
>> +};
>> +\end{lstlisting}
>> +
>> +\drivernormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST set the control general header and corresponding properties of the union in structure virtio_crypto_op_ctrl_req. See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}.
>> +\item The driver MUST set the \field{opcode} field based on service type: CIPHER, HASH, MAC, or AEAD.
> 
>> +\item The driver MUST set the \field{queue_id} field to show used dataq.
> 
> Used for what? Is the driver obligued to use that dataq for the op reqs associated
> with the given session. If yes where is the normative statement?
> 
>> +\end{itemize*}
>> +
>> +\devicenormative{\subparagraph}{Session operation: create session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: create session}
>> +
>> +\begin{itemize*}
>> +\item The device MUST set the \field{session_id} field to a unique session identifier when the device finishes processing session creation.
> 
> I guess only if successfull (that is status == VIRTIO_CRYPTO_OK).
> 
>> +\item The device MUST set the \field{status} field to one of the values of enum VIRTIO_CRYPTO_STATUS.
> 
> Maybe put this one first. The formulation could be more fortunate in
> a sense that it's required to set the right status (_OK if successs,
> _NOTSUPP if ...).
> 
> What shall happen if the operation fails, e.g. becasue of out of resources?
> 
> Is there some sort of limit for the amount of live sessions (related to
> the previous question)? Obviously the device needs storage for the
> session data. Can the guest DOS attack the host by creating an absurd number
> of sessions?
> 
> 
>> +\end{itemize*}
>> +
>> +\drivernormative{\subparagraph}{Session operation: destroy session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: destroy session}
>> +
>> +\begin{itemize*}
>> +\item The driver MUST set the \field{opcode} field based on service type: CIPHER, HASH, MAC, or AEAD.
>> +\item The driver MUST set the \field{session_id} to a valid value assigned by the device when the session was created.
>> +\end{itemize*}
>> +
>> +\devicenormative{\subparagraph}{Session operation: destroy session}{Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation / Session operation: destroy session}
>> +
>> +\begin{itemize*}
>> +\item The device MUST set the \field{status} field to one of the values of enum VIRTIO_CRYPTO_STATUS.
> 
> Same as above.
> 
>> +\end{itemize*}
>> +
>> +\subsubsection{Data Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Data Virtqueue}
>> +
>> +The driver uses the data virtqueue to transmit crypto operation requests to the device,
>> +and completes the crypto operations.
>> +
>> +Session mode dataq requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_data_req {
>> +    struct virtio_crypto_op_header header;
>> +
>> +    union {
>> +        struct virtio_crypto_sym_data_req   sym_req;
>> +        struct virtio_crypto_hash_data_req  hash_req;
>> +        struct virtio_crypto_mac_data_req   mac_req;
>> +        struct virtio_crypto_aead_data_req  aead_req;
>> +    } u;
>> +};
>> +\end{lstlisting}
>> +
>> +Dataq requests for both session and stateless modes are as follows:
> 
> This ain't very nice, I mean the 'both session and stateless modes' together
> with the above 'session mode dataq requests are'. In the meanwhile I know what
> you mean: if the SESSION_MODE feature bit was negotiated.
> 
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_op_data_req_mux {
>> +    struct virtio_crypto_op_header header;
>> +
>> +    union {
>> +        struct virtio_crypto_sym_data_req   sym_req;
>> +        struct virtio_crypto_hash_data_req  hash_req;
>> +        struct virtio_crypto_mac_data_req   mac_req;
>> +        struct virtio_crypto_aead_data_req  aead_req;
>> +        struct virtio_crypto_sym_data_req_stateless   sym_stateless_req;
>> +        struct virtio_crypto_hash_data_req_stateless  hash_stateless_req;
>> +        struct virtio_crypto_mac_data_req_stateless   mac_stateless_req;
>> +        struct virtio_crypto_aead_data_req_stateless  aead_stateless_req;
>> +    } u;
>> +};
>> +\end{lstlisting}
>> +
>> +The header is the general header and the union is of the algorithm-specific type,
>> +which is set by the driver. All properties in the union are shown as follows.
>> +
>> +There is a unified input header structure for all crypto services.
>> +
>> +The structure is defined as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_inhdr {
>> +    u8 status;
>> +};
>> +\end{lstlisting}
>> +
>> +\subsubsection{HASH Service Operation}\label{sec:Device Types / Crypto Device / Device Operation / HASH Service Operation}
>> +
>> +Session mode HASH service requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_hash_para {
>> +    /* length of source data */
>> +    le32 src_data_len;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +};
>> +
>> +struct virtio_crypto_hash_data_req {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_hash_para para;
>> +    /* Source data */
>> +    u8 src_data[src_data_len];
>> +
>> +    /* Device-writable part */
>> +    /* Hash result data */
>> +    u8 hash_result[hash_result_len];
>> +    struct virtio_crypto_inhdr inhdr;
>> +};
>> +\end{lstlisting}
>> +
>> +Each data request uses virtio_crypto_hash_data_req structure to store information
>> +used to run the HASH operations. 
>> +
>> +The information includes the hash parameters stored in \field{para}, output data and input data.
>> +The output data here includes the source data and the input data includes the hash result data used to save the results of the HASH operations.
>> +\field{inhdr} stores the status of executing the HASH operations.
>> +
>> +Stateless mode HASH service requests are as follows:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_hash_para_statelesss {
>> +    struct {
>> +        /* See VIRTIO_CRYPTO_HASH_* above */
>> +        le32 algo;
>> +    } sess_para;
>> +
>> +    /* length of source data */
>> +    le32 src_data_len;
>> +    /* hash result length */
>> +    le32 hash_result_len;
>> +    le32 reserved;
>> +};
>> +struct virtio_crypto_hash_data_req_stateless {
>> +    /* Device-readable part */
>> +    struct virtio_crypto_hash_para_stateless para;
>> +    /* Source data */
>> +    u8 src_data[src_data_len];
>> +
>> +    /* Device-writable part */
>> +    /* Hash result data */
>> +    u8 hash_result[hash_result_len];
>> +    struct virtio_crypto_inhdr inhdr;
>> +};
>> +\end{lstlisting}
>> +
>> +\drivernormative{\paragraph}{HASH Service Operation}{Device Types / Crypto Device / Device Operation / HASH Service Operation}
>> +
>> +\begin{itemize*}
>> +\item If the driver uses the session mode, then the driver MUST set \field{session_id} in struct virtio_crypto_op_header
>> +      to a valid value assigned by the device when the session was created.
>> +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated, the driver MUST use struct virtio_crypto_op_data_req_mux to wrap crypto requests. Otherwise, the driver MUST use struct virtio_crypto_op_data_req.
>> +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiated, 1) if the driver uses the stateless mode, then the driver MUST set the \field{flag} field in struct virtio_crypto_op_header
>> +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set the fields in struct virtio_crypto_hash_para_statelession.sess_para, 2) if the driver uses the session mode, then the driver MUST set the \field{flag} field in struct virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
>> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_header to VIRTIO_CRYPTO_HASH.
>> +\end{itemize*}
>> +
>> +\devicenormative{\paragraph}{HASH Service Operation}{Device Types / Crypto Device / Device Operation / HASH Service Operation}
>> +
>> +\begin{itemize*}
>> +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated, the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto requests. Otherwise, the device MUST parse the struct virtio_crypto_op_data_req.
>> +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiated, the device MUST parse \field{flag} field in struct virtio_crypto_op_header in order to decide which mode the driver uses.
>> +\item The device MUST copy the results of HASH operations in the hash_result[] if HASH operations success.
>> +\item The device MUST set \field{status} in struct virtio_crypto_inhdr to one of the values of enum VIRTIO_CRYPTO_STATUS.
>> +\end{itemize*}
>> +
> 
> OK, I have read this to the end and I don't think there is anything which requires
> a comment at this stage. I would like to concentrate on your QEMU patches first,
> and I think we have enough questions/issues already.
> 
> Regards,
> Halil
> [..]
> 
> 

ping

If you have any need for further discussion on this, I would prefer
having it rather sooner than later. 
