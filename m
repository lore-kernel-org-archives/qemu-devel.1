Received: from eggs.gnu.org ([2001:4830:134:3::10]:43738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1caYVE-0002ru-Fp
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1caYVA-0004e5-PS
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:54:00 -0500
Received: from [45.249.212.189] (port=2384 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1caYV4-0004JW-HM
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:53:56 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 6 Feb 2017 01:48:09 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1AED04@DGGEMA505-MBX.china.huawei.com>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
In-Reply-To: <20170203103316.GA29200@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "claudio.fontana@huawei.com" <claudio.fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>

Hi Stefan,

I'm just back from Chinese New year's holiday.


>
> Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypt=
o
> device specification
>=20
> On Wed, Jan 18, 2017 at 04:22:36PM +0800, Gonglei wrote:
> > The virtio crypto device is a virtual crypto device (ie. hardware
> > crypto accelerator card). Currently, the virtio crypto device provides
> > the following crypto services: CIPHER, MAC, HASH, and AEAD.
> >
> > In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
> >
> > VIRTIO-153
> >
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: Cornelia Huck <cornelia.huck@de.ibm.com>
> > CC: Stefan Hajnoczi <stefanha@redhat.com>
> > CC: Lingli Deng <denglingli@chinamobile.com>
> > CC: Jani Kokkonen <Jani.Kokkonen@huawei.com>
> > CC: Ola Liljedahl <Ola.Liljedahl@arm.com>
> > CC: Varun Sethi <Varun.Sethi@freescale.com>
> > CC: Zeng Xin <xin.zeng@intel.com>
> > CC: Keating Brian <brian.a.keating@intel.com>
> > CC: Ma Liang J <liang.j.ma@intel.com>
> > CC: Griffin John <john.griffin@intel.com>
> > CC: Mihai Claudiu Caraman <mike.caraman@nxp.com>
> > ---
> >  content.tex       |    2 +
> >  virtio-crypto.tex | 1245
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 1247 insertions(+)
> >  create mode 100644 virtio-crypto.tex
>=20
> I'm happy with the device overall.  See specific comments below.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
Thanks!

> >
> > diff --git a/content.tex b/content.tex
> > index 4b45678..ab75f78 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5750,6 +5750,8 @@ descriptor for the \field{sense_len},
> \field{residual},
> >  \field{status_qualifier}, \field{status}, \field{response} and
> >  \field{sense} fields.
> >
> > +\input{virtio-crypto.tex}
> > +
> >  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >
> >  Currently there are three device-independent feature bits defined:
> > diff --git a/virtio-crypto.tex b/virtio-crypto.tex
> > new file mode 100644
> > index 0000000..732cd30
> > --- /dev/null
> > +++ b/virtio-crypto.tex
> > @@ -0,0 +1,1245 @@
> > +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
> > +
> > +The virtio crypto device is a virtual cryptography device as well as a=
 kind of
> > +virtual hardware accelerator for virtual machines. The encryption and
> > +decryption requests are placed in any of the data active queues and ar=
e
> ultimately handled by the
> > +backend crypto accelerators. The second kind of queue is the control q=
ueue
> used to create
> > +or destroy sessions for symmetric algorithms and will control some
> advanced
> > +features in the future. The virtio crypto device provides the followin=
g crypto
> > +services: CIPHER, MAC, HASH, and AEAD.
> > +
> > +
> > +\subsection{Device ID}\label{sec:Device Types / Crypto Device / Device=
 ID}
> > +
> > +20
> > +
> > +\subsection{Virtqueues}\label{sec:Device Types / Crypto Device /
> Virtqueues}
> > +
> > +\begin{description}
> > +\item[0] dataq1
> > +\item[\ldots]
> > +\item[N-1] dataqN
> > +\item[N] controlq
> > +\end{description}
> > +
> > +N is set by \field{max_dataqueues}.
> > +
> > +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Fea=
ture
> bits}
> > +
> > +VIRTIO_CRYPTO_F_NON_SESSION_MODE (0) non-session mode is available.
> > +VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is
> available for CIPHER service.
> > +VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is
> available for HASH service.
> > +VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is
> available for MAC service.
> > +VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is
> available for AEAD service.
>=20
> Bits 1-4 require bit 0.  Is bit 0 necessary at all?  Or may bits 1-4 can
> be eliminated in favor of just bit 0.
>=20
I tried to explain why those bits are necessary in below thread:=20

https://www.mail-archive.com/qemu-devel@nongnu.org/msg423072.html


> > +
> > +\subsubsection{Feature bit requirements}\label{sec:Device Types / Cryp=
to
> Device / Feature bits}
> > +
> > +Some crypto feature bits require other crypto feature bits
> > +(see \ref{drivernormative:Basic Facilities of a Virtio Device / Featur=
e Bits}):
> > +
> > +\begin{description}
> > +\item[VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE] Requires
> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
> > +\item[VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE] Requires
> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
> > +\item[VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE] Requires
> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
> > +\item[VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE] Requires
> VIRTIO_CRYPTO_F_NON_SESSION_MODE.
> > +\end{description}
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / Cryp=
to
> Device / Device configuration layout}
> > +
> > +The following driver-read-only configuration fields are defined:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_config {
> > +    le32 status;
> > +    le32 max_dataqueues;
> > +    le32 crypto_services;
> > +    /* Detailed algorithms mask */
> > +    le32 cipher_algo_l;
> > +    le32 cipher_algo_h;
> > +    le32 hash_algo;
> > +    le32 mac_algo_l;
> > +    le32 mac_algo_h;
> > +    le32 aead_algo;
> > +    /* Maximum length of cipher key */
> > +    le32 max_cipher_key_len;
> > +    /* Maximum length of authenticated key */
> > +    le32 max_auth_key_len;
> > +    le32 reserved;
> > +    /* Maximum size of each crypto request's content */
> > +    le64 max_size;
> > +};
> > +\end{lstlisting}
> > +
> > +The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or
> ~VIRTIO_CRYPTO_S_HW_READY.
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
> > +\end{lstlisting}
> > +
> > +The VIRTIO_CRYPTO_S_HW_READY flag is used to show whether the
> hardware is ready to work or not.
> > +
> > +The following driver-read-only fields include \field{max_dataqueues}, =
which
> specifies the
> > +maximum number of data virtqueues (dataq1\ldots dataqN), and
> \field{crypto_services},
> > +which indicates the crypto services the virtio crypto supports.
> > +
> > +The following services are defined:
> > +
> > +\begin{lstlisting}
> > +/* CIPHER service */
> > +#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
> > +/* HASH service */
> > +#define VIRTIO_CRYPTO_SERVICE_HASH   1
> > +/* MAC (Message Authentication Codes) service */
> > +#define VIRTIO_CRYPTO_SERVICE_MAC    2
> > +/* AEAD (Authenticated Encryption with Associated Data) service */
> > +#define VIRTIO_CRYPTO_SERVICE_AEAD   3
> > +\end{lstlisting}
> > +
> > +The last driver-read-only fields specify detailed algorithms masks
>=20
> s/The last driver-read-only fields/Further driver-read-only fields/
>=20
> (cipher_algo_l, cipher_algo_h, etc are not the last fields.)
>=20
Yes, good insight.

> > +the device offers for corresponding services. The following CIPHER
> algorithms
> > +are defined:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_NO_CIPHER                 0
> > +#define VIRTIO_CRYPTO_CIPHER_ARC4               1
> > +#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
> > +#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
> > +#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
> > +#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
> > +#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
> > +#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
> > +#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
> > +#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
> > +#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
> > +#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
> > +#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
> > +#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
> > +#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
> > +\end{lstlisting}
> > +
> > +The following HASH algorithms are defined:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_NO_HASH            0
> > +#define VIRTIO_CRYPTO_HASH_MD5           1
> > +#define VIRTIO_CRYPTO_HASH_SHA1          2
> > +#define VIRTIO_CRYPTO_HASH_SHA_224       3
> > +#define VIRTIO_CRYPTO_HASH_SHA_256       4
> > +#define VIRTIO_CRYPTO_HASH_SHA_384       5
> > +#define VIRTIO_CRYPTO_HASH_SHA_512       6
> > +#define VIRTIO_CRYPTO_HASH_SHA3_224      7
> > +#define VIRTIO_CRYPTO_HASH_SHA3_256      8
> > +#define VIRTIO_CRYPTO_HASH_SHA3_384      9
> > +#define VIRTIO_CRYPTO_HASH_SHA3_512      10
> > +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
> > +#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
> > +\end{lstlisting}
> > +
> > +The following MAC algorithms are defined:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_NO_MAC                       0
> > +#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
> > +#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
> > +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
> > +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
> > +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
> > +#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
> > +#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
> > +#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
> > +#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
> > +#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
> > +#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
> > +#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
> > +#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
> > +#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
> > +#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
> > +#define VIRTIO_CRYPTO_MAC_ZUC_EIA3                 54
> > +\end{lstlisting}
> > +
> > +The following AEAD algorithms are defined:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_NO_AEAD     0
> > +#define VIRTIO_CRYPTO_AEAD_GCM    1
> > +#define VIRTIO_CRYPTO_AEAD_CCM    2
> > +#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
> > +\end{lstlisting}
> > +
> > +\begin{note}
> > +Any other values are reserved for future use.
> > +\end{note}
> > +
> > +\devicenormative{\subsubsection}{Device configuration layout}{Device T=
ypes
> / Crypto Device / Device configuration layout}
> > +
> > +\begin{itemize*}
> > +\item The device MUST set \field{max_dataqueues} to between 1 and 6553=
5
> inclusive.
> > +\item The device MUST set \field{status} based on the status of the
> hardware-backed implementation.
> > +\item The device MUST accept and handle requests after \field{status} =
is set
> to VIRTIO_CRYPTO_S_HW_READY.
> > +\item The device MUST set \field{crypto_services} based on the crypto
> services the device offers.
> > +\item The device MUST set detailed algorithms masks based on the
> \field{crypto_services} field.
> > +\item The device MUST set \field{max_size} to show the maximum size of
> crypto request the device supports.
>=20
> In bytes?
>=20
> > +\item The device MUST set \field{max_cipher_key_len} to show the
> maximum length of cipher key if the device supports CIPHER service.
>=20
> In bits or bytes?
>=20
> > +\item The device MUST set \field{max_auth_key_len} to show the maximum
> length of authenticated key if the device supports MAC service.
>=20
> In bits or bytes?
>=20

All lengths in virtio crypto spec are bytes.

> > +\end{itemize*}
> > +
> > +\drivernormative{\subsubsection}{Device configuration layout}{Device T=
ypes
> / Crypto Device / Device configuration layout}
> > +
> > +\begin{itemize*}
> > +\item The driver MUST read the ready \field{status} from the bottom bi=
t of
> status to check whether the hardware-backed
> > +      implementation is ready or not, and the driver MUST reread it af=
ter
> the device reset.
> > +\item The driver MUST NOT transmit any packets to the device if the re=
ady
> \field{status} is not set.
> > +\item The driver MUST read \field{max_dataqueues} field to discover th=
e
> number of data queues the device supports.
> > +\item The driver MUST read \field{crypto_services} field to discover w=
hich
> services the device is able to offer.
> > +\item The driver MUST read the detailed algorithms fields based on
> \field{crypto_services} field.
> > +\item The driver SHOULD read \field{max_size} to discover the maximum
> size of crypto request the device supports.
> > +\item The driver SHOULD read \field{max_cipher_key_len} to discover th=
e
> maximum length of cipher key the device supports.
> > +\item The driver SHOULD read \field{max_auth_key_len} to discover the
> maximum length of authenticated key the device supports.
> > +\end{itemize*}
> > +
> > +\subsection{Device Initialization}\label{sec:Device Types / Crypto Dev=
ice /
> Device Initialization}
> > +
> > +\drivernormative{\subsubsection}{Device Initialization}{Device Types /
> Crypto Device / Device Initialization}
> > +
> > +\begin{itemize*}
> > +\item The driver MUST identify and initialize the control virtqueue.
> > +\item The driver MUST read the supported crypto services from bits of
> \field{crypto_services}.
> > +\item The driver MUST read the supported algorithms based on
> \field{crypto_services} field.
> > +\end{itemize*}
> > +
> > +\devicenormative{\subsubsection}{Device Initialization}{Device Types /
> Crypto Device / Device Initialization}
> > +
> > +\begin{itemize*}
> > +\item The device MUST be configured with at least one accelerator whic=
h
> executes backend crypto operations.
> > +\item The device MUST write the \field{crypto_services} field based on=
 the
> capacities of the backend accelerator.
> > +\end{itemize*}
> > +
> > +\subsection{Device Operation}\label{sec:Device Types / Crypto Device /
> Device Operation}
> > +
> > +Packets can be transmitted by placing them in both the controlq and da=
taq.
> > +Packets consist of a general header and a service-specific request.
> > +Where 'general header' is for all crypto requests, and 'service specif=
ic
> requests'
> > +are composed of operation parameter + output data + input data in gene=
ral.
> > +Operation parameters are algorithm-specific parameters, output data is=
 the
> > +data that should be utilized in operations, and input data is equal to
> > +"operation result + result data".
> > +
> > +The device can support both session mode (See \ref{sec:Device Types /
> Crypto Device / Device Operation / Control Virtqueue / Session operation}=
) and
> non-session mode, for example,
> > +As VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE feature bit is
> negotiated, the driver can use non-session mode for CIPHER service, other=
wise
> it can only use session mode.
> > +
> > +\begin{note}
> > +The basic unit of all data length the byte.
>=20
> s/data length the byte/data length is the byte/
>=20
Yes.

> > +\end{note}
> > +
> > +The general header for controlq is as follows:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
> > +
> > +struct virtio_crypto_ctrl_header {
> > +#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER,
> 0x02)
> > +#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER,
> 0x03)
> > +#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
> > +#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
> > +#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
> > +#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
> > +#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
> > +#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
> > +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
> > +    le32 opcode;
> > +    le32 algo;
> > +    le32 flag;
> > +    /* data virtqueue id */
> > +    le32 queue_id;
> > +};
> > +\end{lstlisting}
> > +
> > +The general header of dataq:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_op_header {
> > +#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
> > +#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
> > +#define VIRTIO_CRYPTO_HASH \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
> > +#define VIRTIO_CRYPTO_MAC \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
> > +#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
> > +#define VIRTIO_CRYPTO_AEAD_DECRYPT \
> > +    VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
> > +    le32 opcode;
> > +    /* algo should be service-specific algorithms */
> > +    le32 algo;
> > +    /* session_id should be service-specific algorithms */
> > +    le64 session_id;
> > +#define VIRTIO_CRYPTO_FLAG_SESSION_MODE 1
> > +#define VIRTIO_CRYPTO_FLAG_NON_SESSION_MODE 2
> > +    /* control flag to control the request */
> > +    le32 flag;
> > +    le32 padding;
> > +};
> > +\end{lstlisting}
> > +
> > +The device can set the operation status as follows: VIRTIO_CRYPTO_OK:
> success;
> > +VIRTIO_CRYPTO_ERR: failure or device error; VIRTIO_CRYPTO_NOTSUPP:
> not supported;
> > +VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto
> operations.
> > +
> > +\begin{lstlisting}
> > +enum VIRITO_CRYPTO_STATUS {
> > +    VIRTIO_CRYPTO_OK =3D 0,
> > +    VIRTIO_CRYPTO_ERR =3D 1,
> > +    VIRTIO_CRYPTO_BADMSG =3D 2,
> > +    VIRTIO_CRYPTO_NOTSUPP =3D 3,
> > +    VIRTIO_CRYPTO_INVSESS =3D 4,
> > +    VIRTIO_CRYPTO_MAX
> > +};
> > +\end{lstlisting}
> > +
> > +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Devi=
ce /
> Device Operation / Control Virtqueue}
> > +
> > +The driver uses the control virtqueue to send control commands to the
> > +device which handles the non-data plane operations, such as session
> > +operations (See \ref{sec:Device Types / Crypto Device / Device Operati=
on /
> Control Virtqueue / Session operation}).
> > +
> > +The packet of controlq:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_op_ctrl_req {
> > +    struct virtio_crypto_ctrl_header header;
> > +
> > +    union {
> > +        struct virtio_crypto_sym_create_session_req
> sym_create_session;
> > +        struct virtio_crypto_hash_create_session_req
> hash_create_session;
> > +        struct virtio_crypto_mac_create_session_req
> mac_create_session;
> > +        struct virtio_crypto_aead_create_session_req
> aead_create_session;
> > +        struct virtio_crypto_destroy_session_req      destroy_session;
> > +    } u;
> > +};
> > +\end{lstlisting}
> > +
> > +The header is the general header, and the union is of the algorithm-sp=
ecific
> type,
> > +which is set by the driver. All the properties in the union are shown =
as
> follows.
>=20
> The spec isn't clear on whether crtl reqs should be sizeof(struct
> virtio_crypto_op_ctrl_req) or if it's okay to use the smaller
> sizeof(struct virtio_crypto_ctrl_header) + sizeof(struct
> virtio_crypto_sym_create_session_req), for example.
>=20
> Please clarify.
>=20
It MUST be sizeof(struct virtio_crypto_op_ctrl_req).
I'll clarify it.

Thanks,
-Gonglei
