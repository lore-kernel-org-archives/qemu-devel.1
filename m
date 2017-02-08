Received: from eggs.gnu.org ([2001:4830:134:3::10]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cbLh7-0002Yk-RP
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cbLh4-0000NC-Lf
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:25:33 -0500
Received: from [45.249.212.187] (port=2531 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cbLh0-0000Ll-Qd
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:25:30 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 8 Feb 2017 06:24:26 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1AFFB2@DGGEMA505-MBX.china.huawei.com>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<62a99d8e-1735-0838-4067-bce401c86526@linux.vnet.ibm.com>
In-Reply-To: <62a99d8e-1735-0838-4067-bce401c86526@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: multipart/mixed;
	boundary="_002_33183CC9F5247A488A2544077AF19020DA1AFFB2DGGEMA505MBXchi_"
MIME-Version: 1.0
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>

--_002_33183CC9F5247A488A2544077AF19020DA1AFFB2DGGEMA505MBXchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Halil,

Thanks for your comments firstly.

>=20
> On 01/18/2017 09:22 AM, Gonglei wrote:
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
>=20
> Am I the only one having a problem with 'data active queues'?

Maybe 'data queues' here is enough?

> I have objected on this before.
>=20
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
> > +
>=20
> I'm not sure that "non-session" entirely correct grammatically. I would
> prefer sessionless as alternatively proposed by Stefan, or even stateless=
.
> I think stateless is the phrase most frequently used to describe what
> we want to introduce -- that is basically response =3D f(request) and
> not response =3D f(request, server_state) where the server_state is
> a is determined by a series of previous interactions between the server
> and the client).
>=20
Makes sense. I discussed with Xin about this on call meeting two weeks ago.
I decide to use stateless mode instead of non-session mode here.

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
>=20
> Not entirely happy with this. What you want to say is reserved
> for future use, or? Would it make sense to have a general note
> -- in a similar fashion like for 'sizes are in bytes' -- for
> reserved for future use?
>=20
> One possible formulation would be:
>=20
> "In this specification, unless explicitly stated otherwise,
> fields and bits reserved for future use shall be zeroed out.
> Both the a device or a driver device and the driver should
> detect violations of this rule, and deny the requested
> operation in an appropriate way if possible."
>=20
>=20
Cornelia also provided a good suggestion about this. :)

> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
> > +\end{lstlisting}
> > +
> > +The VIRTIO_CRYPTO_S_HW_READY flag is used to show whether the
> hardware is ready to work or not.
>=20
> I do not like hardware here.
>=20
Sorry about that, but it has existed in both Qemu and Linux driver. :(

> > +
> > +The following driver-read-only fields include \field{max_dataqueues}, =
which
> specifies the
>=20
> Why following?
>=20
Er, I used 'following' at here and there... It's just an auxiliary word.

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
> > +the device offers for corresponding services. The following CIPHER
> algorithms
> > +are defined:
>=20
> You do not establish an explicit relationship between the fields and the
> macros for the flags. These are flags or? It seems quite common in the
> spec to use _F_ in flag names. Would it be appropriate here?
>=20
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
>=20
> Would it make sense to interleave the flag definition
> with the struct virtio_crypto_config?
>=20
> > +\begin{note}
> > +Any other values are reserved for future use.
>=20
> Are these flags or values? I do not think values is appropriate here.
>=20
Please refer to my reply in another thread.

> > +\end{note}
> > +
>=20
> Some fields are missing here. This is inconsistent. Either
> you should describe all or none (here).
>=20
Ok, will add other fields.

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
>=20
> What is a hardware-backend?
>=20
I meant the cryptodev backend, cryptodev-builtin, cryptodev-vhost-user for =
example.

> > +\item The device MUST accept and handle requests after \field{status} =
is set
> to VIRTIO_CRYPTO_S_HW_READY.
>=20
> Shouldn't this be the other way around (if VIRTIO_CRYPTO_S_HW_READY
> then reject). Is a not well formed request or a backend failure considere=
d?
> What does handle mean? What should happen if requests are submitted
> before VIRTIO_CRYPTO_S_HW_READY is set?
>=20
The requests MUST not be transmitted before VIRTIO_CRYPTO_S_HW_READY is set=
.
Which is stated by the driver requirements. Otherwise the requests will be =
dropped.

The handle means execute crypto operations.

> > +\item The device MUST set \field{crypto_services} based on the crypto
> services the device offers.
> > +\item The device MUST set detailed algorithms masks based on the
> \field{crypto_services} field.
> > +\item The device MUST set \field{max_size} to show the maximum size of
> crypto request the device supports.
> > +\item The device MUST set \field{max_cipher_key_len} to show the
> maximum length of cipher key if the device supports CIPHER service.
> > +\item The device MUST set \field{max_auth_key_len} to show the maximum
> length of authenticated key if the device supports MAC service.
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
>=20
> But does not have to identify and initialize any data virtqueues?
>=20
Good catch. Both controlq and dataq.

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
>=20
> What does configured mean here? Is this initialization requirement.
>=20
It means the virtio crypto device MUST attach cryptodev backend.=20
Yes, it's a requirement.

> > +\item The device MUST write the \field{crypto_services} field based on=
 the
> capacities of the backend accelerator.
> > +\end{itemize*}
> > +
>=20
> How do 'Initialization' and 'Configuration Layout' requirements relate to
> each-other.
>=20
Basically they do the same things. But 'configuration layout' can't state t=
he
specific time.
=20
> > +\subsection{Device Operation}\label{sec:Device Types / Crypto Device /
> Device Operation}
> > +
> > +Packets can be transmitted by placing them in both the controlq and da=
taq.
> > +Packets consist of a general header and a service-specific request.
>=20
> Are packets and requests synonyms?
>=20
Yes, they are in virtio crypto spec.

> > +Where 'general header' is for all crypto requests, and 'service specif=
ic
> requests'
>=20
> From below it seems you have two types of 'general header', but up until =
this
> point it seems there is a single definition. Of course, this does not
> really matter.
>=20
I distinguish it based on controlq and dataq in following statement.

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
>=20
> Grammar: Does not seem right to me. 'As' seems off and this could be two
> sentences.
>=20
OK. Let me s/As/If the/ here.

>=20
> > +
> > +\begin{note}
> > +The basic unit of all data length the byte.
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
>=20
> Use _F_ istead of _FLAG_?
>=20
I'm afraid they are confused with the feature bits.

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
>=20
> What is a 'non-data plane'?
>=20
I named controlling plane as the non-data plane. Maybe it's superfluous.

> > +operations (See \ref{sec:Device Types / Crypto Device / Device Operati=
on /
> Control Virtqueue / Session operation}).
>=20
> Reviewed up until here. Depending on how things evolve will try to
> review the rest too in the following days.
>=20
I knew it's a hard and time-consuming work to review such long spec.

Great thanks for your reviewing. :)

> A question and a remark as a closing word:
> * Are there already some kernel and qemu patches for this 'non-session' s=
tuff?

THB currently I have a patch for virtio_crypto.h.=20

Attaching it for better review.

> * I think some proofreading (and eventually also touch-up) by a native sp=
eaker
> would really benefit us. Sadly my grammar skills are very questionable, s=
o
> I can't help much. Nevertheless since it is a spec, I think we sould stri=
ve
> for high standards in language usage too.
>=20
I agree and I actually asked a native speaker in my company to review it=20
several months ago. When all comments are handled, I'll do it again.

Thanks,
-Gonglei


--_002_33183CC9F5247A488A2544077AF19020DA1AFFB2DGGEMA505MBXchi_
Content-Type: application/octet-stream;
	name="0001-virtio-crypto-update-header-file.patch"
Content-Description: 0001-virtio-crypto-update-header-file.patch
Content-Disposition: attachment;
	filename="0001-virtio-crypto-update-header-file.patch"; size=6550;
	creation-date="Wed, 08 Feb 2017 06:23:41 GMT";
	modification-date="Wed, 08 Feb 2017 06:24:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmMTJmNzgzNmIyNDBjODY4MDMxYzVlNmEwYjljZmYzNzdkYzNjOTY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHb25nbGVpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT4KRGF0
ZTogRnJpLCAyMCBKYW4gMjAxNyAxNjoyMjo1NCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHZpcnRp
by1jcnlwdG86IHVwZGF0ZSBoZWFkZXIgZmlsZQoKVXBkYXRlIHRoZSBoZWFkZXIgYmFzZWQgb24g
dGhlIG5ld3NldCB2aXJ0aW8KY3J5cHRvIHNwZWMsIHNvIHRoYXQgdGhlIHZpcnRpbyBjcnlwdG8g
Y2FuCnN1cHBvcnQgYm90aCBzZXNzaW9uIGFuZCBub24tc2Vzc2lvbiBiYXNlZApjcnlwdG8gc2Vy
dmljZXMgYW5kIGtlZXAgY29tcGF0aWJpbGl0eSB3aXRoCnRoZSBwcmUtZXhpc3RpbmcgY29kZS4K
ClNpZ25lZC1vZmYtYnk6IEdvbmdsZWkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPgotLS0KIGlu
Y2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fY3J5cHRvLmggfCAxOTYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE5NCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fY3J5
cHRvLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NyeXB0by5oCmluZGV4IDUwY2RjOGEu
LmYzMDM4OWMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fY3J5cHRvLmgK
KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19jcnlwdG8uaApAQCAtMTY2LDggKzE2Niw4
IEBAIHN0cnVjdCB2aXJ0aW9fY3J5cHRvX2FlYWRfc2Vzc2lvbl9wYXJhIHsKIAlfX2xlMzIgYWxn
bzsKIAkvKiBsZW5ndGggb2Yga2V5ICovCiAJX19sZTMyIGtleV9sZW47Ci0JLyogaGFzaCByZXN1
bHQgbGVuZ3RoICovCi0JX19sZTMyIGhhc2hfcmVzdWx0X2xlbjsKKwkvKiBBdXRoZW50aWNhdGlv
biB0YWcgbGVuZ3RoICovCisJX192aXJ0aW8zMiB0YWdfbGVuOwogCS8qIGxlbmd0aCBvZiB0aGUg
YWRkaXRpb25hbCBhdXRoZW50aWNhdGVkIGRhdGEgKEFBRCkgaW4gYnl0ZXMgKi8KIAlfX2xlMzIg
YWFkX2xlbjsKIAkvKiBlbmNyeXB0IG9yIGRlY3J5cHQsIFNlZSBhYm92ZSBWSVJUSU9fQ1JZUFRP
X09QXyogKi8KQEAgLTI3MSw2ICsyNzEsOCBAQCBzdHJ1Y3QgdmlydGlvX2NyeXB0b19vcF9oZWFk
ZXIgewogCV9fbGUzMiBhbGdvOwogCS8qIHNlc3Npb25faWQgc2hvdWxkIGJlIHNlcnZpY2Utc3Bl
Y2lmaWMgYWxnb3JpdGhtcyAqLwogCV9fbGU2NCBzZXNzaW9uX2lkOworI2RlZmluZSBWSVJUSU9f
Q1JZUFRPX0ZMQUdfU0VTU0lPTl9NT0RFIDEKKyNkZWZpbmUgVklSVElPX0NSWVBUT19GTEFHX05P
Tl9TRVNTSU9OX01PREUgMgogCS8qIGNvbnRyb2wgZmxhZyB0byBjb250cm9sIHRoZSByZXF1ZXN0
ICovCiAJX19sZTMyIGZsYWc7CiAJX19sZTMyIHBhZGRpbmc7CkBAIC00MDMsNiArNDA1LDE5NiBA
QCBzdHJ1Y3QgdmlydGlvX2NyeXB0b19vcF9kYXRhX3JlcSB7CiAJfSB1OwogfTsKIAorc3RydWN0
IHZpcnRpb19jcnlwdG9fY2lwaGVyX3BhcmFfbm9uX3Nlc3MgeworCXN0cnVjdCB7CisJCS8qIFNl
ZSBWSVJUSU9fQ1JZUFRPX0NJUEhFUiogYWJvdmUgKi8KKwkJX192aXJ0aW8zMiBhbGdvOworCQkv
KiBsZW5ndGggb2Yga2V5ICovCisJCV9fdmlydGlvMzIga2V5bGVuOworCisJCS8qIFNlZSBWSVJU
SU9fQ1JZUFRPX09QXyogYWJvdmUgKi8KKwkJX192aXJ0aW8zMiBvcDsKKwl9IHNlc3NfcGFyYTsK
KworCS8qCisJICogQnl0ZSBMZW5ndGggb2YgdmFsaWQgSVYvQ291bnRlcgorCSAqLworCV9fdmly
dGlvMzIgaXZfbGVuOworCS8qIGxlbmd0aCBvZiBzb3VyY2UgZGF0YSAqLworCV9fdmlydGlvMzIg
c3JjX2RhdGFfbGVuOworCS8qIGxlbmd0aCBvZiBkc3QgZGF0YSAqLworCV9fdmlydGlvMzIgZHN0
X2RhdGFfbGVuOworfTsKKworc3RydWN0IHZpcnRpb19jcnlwdG9fYWxnX2NoYWluX2RhdGFfcGFy
YV9ub25fc2VzcyB7CisJc3RydWN0IHsKKwkJLyogU2VlIFZJUlRJT19DUllQVE9fU1lNX0FMR19D
SEFJTl9PUkRFUl8qIGFib3ZlICovCisJCV9fdmlydGlvMzIgYWxnX2NoYWluX29yZGVyOworCQkv
KiBsZW5ndGggb2YgdGhlIGFkZGl0aW9uYWwgYXV0aGVudGljYXRlZCBkYXRhIGluIGJ5dGVzICov
CisJCV9fdmlydGlvMzIgYWFkX2xlbjsKKworCQlzdHJ1Y3QgeworCQkJLyogU2VlIFZJUlRJT19D
UllQVE9fQ0lQSEVSKiBhYm92ZSAqLworCQkJX192aXJ0aW8zMiBhbGdvOworCQkJLyogbGVuZ3Ro
IG9mIGtleSAqLworCQkJX192aXJ0aW8zMiBrZXlsZW47CisJCQkvKiBTZWUgVklSVElPX0NSWVBU
T19PUF8qIGFib3ZlICovCisJCQlfX3ZpcnRpbzMyIG9wOworCQl9IGNpcGhlcjsKKworCQlzdHJ1
Y3QgeworCQkJLyogU2VlIFZJUlRJT19DUllQVE9fSEFTSF8qIG9yIF9NQUNfKiBhYm92ZSAqLwor
CQkJX192aXJ0aW8zMiBhbGdvOworCQkJLyogbGVuZ3RoIG9mIGF1dGhlbnRpY2F0ZWQga2V5ICov
CisJCQlfX3ZpcnRpbzMyIGF1dGhfa2V5X2xlbjsKKwkJCS8qIFNlZSBWSVJUSU9fQ1JZUFRPX1NZ
TV9IQVNIX01PREVfKiBhYm92ZSAqLworCQkJX192aXJ0aW8zMiBoYXNoX21vZGU7CisJCX0gaGFz
aDsKKwl9IHNlc3NfcGFyYTsKKworCV9fdmlydGlvMzIgaXZfbGVuOworCS8qIExlbmd0aCBvZiBz
b3VyY2UgZGF0YSAqLworCV9fdmlydGlvMzIgc3JjX2RhdGFfbGVuOworCS8qIExlbmd0aCBvZiBk
ZXN0aW5hdGlvbiBkYXRhICovCisJX192aXJ0aW8zMiBkc3RfZGF0YV9sZW47CisJLyogU3RhcnRp
bmcgcG9pbnQgZm9yIGNpcGhlciBwcm9jZXNzaW5nIGluIHNvdXJjZSBkYXRhICovCisJX192aXJ0
aW8zMiBjaXBoZXJfc3RhcnRfc3JjX29mZnNldDsKKwkvKiBMZW5ndGggb2YgdGhlIHNvdXJjZSBk
YXRhIHRoYXQgdGhlIGNpcGhlciB3aWxsIGJlIGNvbXB1dGVkIG9uICovCisJX192aXJ0aW8zMiBs
ZW5fdG9fY2lwaGVyOworCS8qIFN0YXJ0aW5nIHBvaW50IGZvciBoYXNoIHByb2Nlc3NpbmcgaW4g
c291cmNlIGRhdGEgKi8KKwlfX3ZpcnRpbzMyIGhhc2hfc3RhcnRfc3JjX29mZnNldDsKKwkvKiBM
ZW5ndGggb2YgdGhlIHNvdXJjZSBkYXRhIHRoYXQgdGhlIGhhc2ggd2lsbCBiZSBjb21wdXRlZCBv
biAqLworCV9fdmlydGlvMzIgbGVuX3RvX2hhc2g7CisJLyogTGVuZ3RoIG9mIHRoZSBhZGRpdGlv
bmFsIGF1dGggZGF0YSAqLworCV9fdmlydGlvMzIgYWFkX2xlbjsKKwkvKiBMZW5ndGggb2YgdGhl
IGhhc2ggcmVzdWx0ICovCisJX192aXJ0aW8zMiBoYXNoX3Jlc3VsdF9sZW47CisJX192aXJ0aW8z
MiByZXNlcnZlZDsKK307CisKK3N0cnVjdCB2aXJ0aW9fY3J5cHRvX2hhc2hfcGFyYV9ub25fc2Vz
cyB7CisJc3RydWN0IHsKKwkJLyogU2VlIFZJUlRJT19DUllQVE9fSEFTSF8qIGFib3ZlICovCisJ
CV9fdmlydGlvMzIgYWxnbzsKKwl9IHNlc3NfcGFyYTsKKworCS8qIGxlbmd0aCBvZiBzb3VyY2Ug
ZGF0YSAqLworCV9fdmlydGlvMzIgc3JjX2RhdGFfbGVuOworCS8qIGhhc2ggcmVzdWx0IGxlbmd0
aCAqLworCV9fdmlydGlvMzIgaGFzaF9yZXN1bHRfbGVuOworCV9fdmlydGlvMzIgcmVzZXJ2ZWQ7
Cit9OworCitzdHJ1Y3QgdmlydGlvX2NyeXB0b19tYWNfcGFyYV9ub25fc2VzcyB7CisJc3RydWN0
IHsKKwkJLyogU2VlIFZJUlRJT19DUllQVE9fTUFDXyogYWJvdmUgKi8KKwkJX192aXJ0aW8zMiBh
bGdvOworCQkvKiBsZW5ndGggb2YgYXV0aGVudGljYXRlZCBrZXkgKi8KKwkJX192aXJ0aW8zMiBh
dXRoX2tleV9sZW47CisJfSBzZXNzX3BhcmE7CisKKwkvKiBsZW5ndGggb2Ygc291cmNlIGRhdGEg
Ki8KKwlfX3ZpcnRpbzMyIHNyY19kYXRhX2xlbjsKKwkvKiBoYXNoIHJlc3VsdCBsZW5ndGggKi8K
KwlfX3ZpcnRpbzMyIGhhc2hfcmVzdWx0X2xlbjsKK307CisKK3N0cnVjdCB2aXJ0aW9fY3J5cHRv
X2FlYWRfcGFyYV9ub25fc2VzcyB7CisJc3RydWN0IHsKKwkJLyogU2VlIFZJUlRJT19DUllQVE9f
QUVBRF8qIGFib3ZlICovCisJCV9fdmlydGlvMzIgYWxnbzsKKwkJLyogbGVuZ3RoIG9mIGtleSAq
LworCQlfX3ZpcnRpbzMyIGtleV9sZW47CisJCS8qIGVuY3J5cHQgb3IgZGVjcnlwdCwgU2VlIGFi
b3ZlIFZJUlRJT19DUllQVE9fT1BfKiAqLworCQlfX3ZpcnRpbzMyIG9wOworCX0gc2Vzc19wYXJh
OworCisJLyoKKwkgKiBCeXRlIExlbmd0aCBvZiB2YWxpZCBJViBkYXRhIHBvaW50ZWQgdG8gYnkg
dGhlIGJlbG93IGl2X2FkZHIKKwkgKiBwYXJhbWV0ZXIuCisJICovCisJX192aXJ0aW8zMiBpdl9s
ZW47CisJLyogQXV0aGVudGljYXRpb24gdGFnIGxlbmd0aCAqLworCV9fdmlydGlvMzIgdGFnX2xl
bjsKKwkvKiBsZW5ndGggb2YgdGhlIGFkZGl0aW9uYWwgYXV0aGVudGljYXRlZCBkYXRhIChBQUQp
IGluIGJ5dGVzICovCisJX192aXJ0aW8zMiBhYWRfbGVuOworCS8qIGxlbmd0aCBvZiBzb3VyY2Ug
ZGF0YSAqLworCV9fdmlydGlvMzIgc3JjX2RhdGFfbGVuOworCS8qIGxlbmd0aCBvZiBkc3QgZGF0
YSwgaXQgc2hvdWxkIGJlIGF0IGxlYXN0IHNyY19kYXRhX2xlbiArIHRhZ19sZW4gKi8KKwlfX3Zp
cnRpbzMyIGRzdF9kYXRhX2xlbjsKK307CisKK3N0cnVjdCB2aXJ0aW9fY3J5cHRvX2NpcGhlcl9k
YXRhX3JlcV9ub25fc2VzcyB7CisJLyogRGV2aWNlLXJlYWRhYmxlIHBhcnQgKi8KKwlzdHJ1Y3Qg
dmlydGlvX2NyeXB0b19jaXBoZXJfcGFyYV9ub25fc2VzcyBwYXJhOworCV9fdTggcGFkZGluZ1s0
OF07Cit9OworCitzdHJ1Y3QgdmlydGlvX2NyeXB0b19oYXNoX2RhdGFfcmVxX25vbl9zZXNzIHsK
KwkvKiBEZXZpY2UtcmVhZGFibGUgcGFydCAqLworCXN0cnVjdCB2aXJ0aW9fY3J5cHRvX2hhc2hf
cGFyYV9ub25fc2VzcyBwYXJhOworCV9fdTggcGFkZGluZ1s2NF07Cit9OworCitzdHJ1Y3Qgdmly
dGlvX2NyeXB0b19tYWNfZGF0YV9yZXFfbm9uX3Nlc3MgeworCS8qIERldmljZS1yZWFkYWJsZSBw
YXJ0ICovCisJc3RydWN0IHZpcnRpb19jcnlwdG9fbWFjX3BhcmFfbm9uX3Nlc3MgcGFyYTsKKwlf
X3U4IHBhZGRpbmdbNjRdOworfTsKKworc3RydWN0IHZpcnRpb19jcnlwdG9fYWxnX2NoYWluX2Rh
dGFfcmVxX25vbl9zZXNzIHsKKwkvKiBEZXZpY2UtcmVhZGFibGUgcGFydCAqLworCXN0cnVjdCB2
aXJ0aW9fY3J5cHRvX2FsZ19jaGFpbl9kYXRhX3BhcmFfbm9uX3Nlc3MgcGFyYTsKK307CisKK3N0
cnVjdCB2aXJ0aW9fY3J5cHRvX3N5bV9kYXRhX3JlcV9ub25fc2VzcyB7CisJdW5pb24geworCQlz
dHJ1Y3QgdmlydGlvX2NyeXB0b19jaXBoZXJfZGF0YV9yZXFfbm9uX3Nlc3MgY2lwaGVyOworCQlz
dHJ1Y3QgdmlydGlvX2NyeXB0b19hbGdfY2hhaW5fZGF0YV9yZXFfbm9uX3Nlc3MgY2hhaW47CisJ
CV9fdTggcGFkZGluZ1s3Ml07CisJfSB1OworCisJLyogU2VlIGFib3ZlIFZJUlRJT19DUllQVE9f
U1lNX09QXyogKi8KKwlfX2xlMzIgb3BfdHlwZTsKKwlfX2xlMzIgcGFkZGluZzsKK307CisKK3N0
cnVjdCB2aXJ0aW9fY3J5cHRvX2FlYWRfZGF0YV9yZXFfbm9uX3Nlc3MgeworCS8qIERldmljZS1y
ZWFkYWJsZSBwYXJ0ICovCisJc3RydWN0IHZpcnRpb19jcnlwdG9fYWVhZF9wYXJhX25vbl9zZXNz
IHBhcmE7CisJX191OCBwYWRkaW5nWzQ4XTsKK307CisKKy8qIFRoZSByZXF1ZXN0IG9mIHRoZSBk
YXRhIHZpcnRxdWV1ZSdzIHBhY2tldCAqLworc3RydWN0IHZpcnRpb19jcnlwdG9fb3BfZGF0YV9y
ZXFfbXV4IHsKKwlzdHJ1Y3QgdmlydGlvX2NyeXB0b19vcF9oZWFkZXIgaGVhZGVyOworCisJdW5p
b24geworCQlzdHJ1Y3QgeworCQkJc3RydWN0IHZpcnRpb19jcnlwdG9fc3ltX2RhdGFfcmVxICBk
YXRhOworCQkJX191OCBwYWRkaW5nWzMyXTsKKwkJfSBzeW1fcmVxOworCQlzdHJ1Y3QgeworCQkJ
c3RydWN0IHZpcnRpb19jcnlwdG9faGFzaF9kYXRhX3JlcSBkYXRhOworCQkJX191OCBwYWRkaW5n
WzMyXTsKKwkJfSBoYXNoX3JlcTsKKwkJc3RydWN0IHsKKwkJCXN0cnVjdCB2aXJ0aW9fY3J5cHRv
X21hY19kYXRhX3JlcSBkYXRhOworCQkJX191OCBwYWRkaW5nWzMyXTsKKwkJfSBtYWNfcmVxOwor
CQlzdHJ1Y3QgeworCQkJc3RydWN0IHZpcnRpb19jcnlwdG9fYWVhZF9kYXRhX3JlcSBkYXRhOwor
CQkJX191OCBwYWRkaW5nWzMyXTsKKwkJfSBhZWFkX3JlcTsKKworCQlzdHJ1Y3QgdmlydGlvX2Ny
eXB0b19zeW1fZGF0YV9yZXFfbm9uX3Nlc3MgIHN5bV9ub25fc2Vzc19yZXE7CisJCXN0cnVjdCB2
aXJ0aW9fY3J5cHRvX2hhc2hfZGF0YV9yZXFfbm9uX3Nlc3MgaGFzaF9ub25fc2Vzc19yZXE7CisJ
CXN0cnVjdCB2aXJ0aW9fY3J5cHRvX21hY19kYXRhX3JlcV9ub25fc2VzcyBtYWNfbm9uX3Nlc3Nf
cmVxOworCQlzdHJ1Y3QgdmlydGlvX2NyeXB0b19hZWFkX2RhdGFfcmVxX25vbl9zZXNzIGFlYWRf
bm9uX3Nlc3NfcmVxOworCQlfX3U4IHBhZGRpbmdbODBdOworCX0gdTsKK307CisKICNkZWZpbmUg
VklSVElPX0NSWVBUT19PSyAgICAgICAgMAogI2RlZmluZSBWSVJUSU9fQ1JZUFRPX0VSUiAgICAg
ICAxCiAjZGVmaW5lIFZJUlRJT19DUllQVE9fQkFETVNHICAgIDIKLS0gCjEuOC4zLjEKCg==

--_002_33183CC9F5247A488A2544077AF19020DA1AFFB2DGGEMA505MBXchi_--
