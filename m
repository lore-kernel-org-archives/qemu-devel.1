Received: from eggs.gnu.org ([2001:4830:134:3::10]:41873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d0igC-0000Zu-Gz
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d0ig9-0003rd-AH
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:01:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3487
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d0ig7-0003mM-Ug
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:01:25 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 19 Apr 2017 06:01:00 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2347D2@DGGEMA505-MBS.china.huawei.com>
References: <1492074674-124192-1-git-send-email-arei.gonglei@huawei.com>
	<1492074674-124192-2-git-send-email-arei.gonglei@huawei.com>
	<20170418170140.GM21261@stefanha-x1.localdomain>
In-Reply-To: <20170418170140.GM21261@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v17 1/2] virtio-crypto: Add virtio crypto
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Zhbzg <zhbzg@huawei.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, Maoningning <maoningning@huawei.com>, "Wubin (H)" <wu.wubin@huawei.com>

Hi Stefan,

Thanks for your comments firstly. :)

>
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Wednesday, April 19, 2017 1:02 AM
> Subject: Re: [Qemu-devel] [PATCH v17 1/2] virtio-crypto: Add virtio crypt=
o
> device specification
>=20
> On Thu, Apr 13, 2017 at 05:11:13PM +0800, Gonglei wrote:
>=20
> More grammar fixes and the reasoning behind my suggestions.  I've only
> reviewed 1/3rd of this patch so far.
>=20
OK, please go ahead if you can, thanks :)

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
> > CC: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> >  acknowledgements.tex |    1 +
> >  content.tex          |    2 +
> >  virtio-crypto.tex    | 1305
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1308 insertions(+)
> >  create mode 100644 virtio-crypto.tex
> >
> > diff --git a/acknowledgements.tex b/acknowledgements.tex
> > index 53942b0..6714544 100644
> > --- a/acknowledgements.tex
> > +++ b/acknowledgements.tex
> > @@ -44,4 +44,5 @@ Patrick Durusau,	Technical Advisory Board, OASIS
> 	\newline
> >  Thomas Huth,	Red Hat	\newline
> >  Yan Vugenfirer, Red Hat / Daynix	\newline
> >  Kevin Lo,	MSI	\newline
> > +Halil Pasic, IBM  \newline
> >  \end{oasistitlesection}
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
> > index 0000000..c73a1ef
> > --- /dev/null
> > +++ b/virtio-crypto.tex
> > @@ -0,0 +1,1305 @@
> > +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
> > +
> > +The virtio crypto device is a virtual cryptography device as well as a=
 kind of
> > +virtual hardware accelerator for virtual machines. The encryption and
> > +decryption requests are placed in any of the data queues and are ultim=
ately
> handled by the
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
> > +VIRTIO_CRYPTO_F_STATELESS_MODE (0) stateless mode is available.
> > +VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE (1) stateless mode is
> available for CIPHER service.
> > +VIRTIO_CRYPTO_F_HASH_STATELESS_MODE (2) stateless mode is available
> for HASH service.
> > +VIRTIO_CRYPTO_F_MAC_STATELESS_MODE (3) stateless mode is available
> for MAC service.
> > +VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE (4) stateless mode is available
> for AEAD service.
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
> > +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires
> VIRTIO_CRYPTO_F_STATELESS_MODE.
> > +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires
> VIRTIO_CRYPTO_F_STATELESS_MODE.
> > +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires
> VIRTIO_CRYPTO_F_STATELESS_MODE.
> > +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires
> VIRTIO_CRYPTO_F_STATELESS_MODE.
> > +\end{description}
> > +
> > +\subsection{Supported crypto services}\label{sec:Device Types / Crypto
> Device / Supported crypto services}
> > +
> > +The virtio crypto device provides the following crypto services: CIPHE=
R, MAC,
> HASH, and AEAD.
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
> > +The above constants are bit numbers, which used to tell the driver whi=
ch
> crypto services
>=20
> "which are used" but it can be shortened:
>=20
> s/which used to tell/which tell/
>=20
OK

> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +
> > +\subsubsection{CIPHER services}\label{sec:Device Types / Crypto Device=
 /
> Supported crypto services / CIPHER services}
> > +
> > +The following CIPHER algorithms are defined:
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
> > +The above constants have two usages:
> > +\begin{enumerate}
> > +\item As bit numbers, which used to tell the driver which CIPHER algor=
ithms
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, which used to tell the device which CIPHER algorithm
> > +a crypto request require by the driver, see \ref{sec:Device Types / Cr=
ypto
> Device / Device Operation / Control Virtqueue / Session operation}.
>=20
> s/request require by the driver/request from the driver requires/
>=20
OK.

> > +\end{enumerate}
> > +
> > +\subsubsection{HASH services}\label{sec:Device Types / Crypto Device /
> Supported crypto services / HASH services}
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
> > +The above constants have two usages:
> > +\begin{enumerate}
> > +\item As bit numbers, which used to tell the driver which HASH algorit=
hms
>=20
> s/which used/used/
>=20
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, which used to tell the device which HASH algorithm
>=20
> s/which used/used/
>=20
> > +a crypto request require by the driver, see \ref{sec:Device Types / Cr=
ypto
> Device / Device Operation / Control Virtqueue / Session operation}.
>=20
> s/request require by the driver/request from the driver requires/
>=20
> (It's "I require" and "you require" but "he/she/it requires")
>=20
Yes, fixed.

> > +\end{enumerate}
> > +
> > +\subsubsection{MAC services}\label{sec:Device Types / Crypto Device /
> Supported crypto services / MAC services}
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
> > +The above constants have two usages:
> > +\begin{enumerate}
> > +\item As bit numbers, which used to tell the driver which MAC algorith=
ms
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, which used to tell the device which MAC algorithm
> > +a crypto request require by the driver, see \ref{sec:Device Types / Cr=
ypto
> Device / Device Operation / Control Virtqueue / Session operation}.
> > +\end{enumerate}
>=20
> Same as above.
>=20
> > +
> > +\subsubsection{AEAD services}\label{sec:Device Types / Crypto Device /
> Supported crypto services / AEAD services}
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
> > +The above constants have two usages:
> > +\begin{enumerate}
> > +\item As bit numbers, which used to tell the driver which AEAD algorit=
hms
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, which used to tell the device what AEAD algorithm
> > +a crypto request require by the driver, see \ref{sec:Device Types / Cr=
ypto
> Device / Device Operation / Control Virtqueue / Session operation}.
> > +\end{enumerate}
>=20
> Same as above.
>=20
Fixed.

> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / Cryp=
to
> Device / Device configuration layout}
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
> > +    /* Maximum length of cipher key in bytes */
> > +    le32 max_cipher_key_len;
> > +    /* Maximum length of authenticated key in bytes */
> > +    le32 max_auth_key_len;
> > +    le32 reserved;
> > +    /* Maximum size of each crypto request's content in bytes */
> > +    le64 max_size;
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{status}] is used to show whether the device is ready to w=
ork or
> not, it can be either zero or have one or more flags
> > +    Only one read-only bit (for the driver) is currently defined for t=
he
> \field{status} field: VIRTIO_CRYPTO_S_HW_READY:
> > +\begin{lstlisting}
> > +#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
> > +\end{lstlisting}
> > +
> > +\item[\field{max_dataqueues}] is the maximum number of data virtqueues
> exposed by
> > +    the device. The driver MAY use only one data queue,
> > +    or it can use more to achieve better performance.
> > +
> > +\item[\field{crypto_services}] is a 32-bit mask which indicates the cr=
ypto
> services supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services}.
> > +
> > +\item[\field{cipher_algo_l}] is the low 32-bit mask wihich indicates t=
he
> CIPHER algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / CIPHER services}.
> > +
> > +\item[\field{cipher_algo_h}] is the high 32-bit mask wihich indicates =
the
> CIPHER algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / CIPHER services}.
> > +
> > +\item[\field{hash_algo}] is a 32-bit mask wihich indicates the HASH
> algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / HASH services}.
> > +
> > +\item[\field{mac_algo_l}] is the low 32-bit mask wihich indicates the =
MAC
> algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / MAC services}.
> > +
> > +\item[\field{mac_algo_h}] is the high 32-bit mask wihich indicates the=
 MAC
> algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / MAC services}.
> > +
> > +\item[\field{aead_algo}] is a 32-bit mask wihich indicates the AEAD
> algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / AEAD services}.
> > +
> > +\item[\field{max_cipher_key_len}] is the maximum length of cipher key
> supported by the device.
> > +
> > +\item[\field{max_auth_key_len}] is the maximum length of authenticated
> key supported by the device.
> > +
> > +\item[\field{reserved}] is reserved for future use.
> > +
> > +\item[\field{max_size}] is the maximum size of each crypto request's
> content supported by the device
> > +\end{description}
> > +
> > +\begin{note}
> > +Unless explicitly stated otherwise all lengths and sizes are in bytes.
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
> > +\item The device MUST set \field{status} based on the status of the ba=
ckend
> crypto accelerator.
> > +\item The device MUST accept and handle requests after \field{status} =
is set
> to VIRTIO_CRYPTO_S_HW_READY.
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
> status to check whether the backend crypto accelerator
> > +      is ready or not, and the driver MUST reread it after the device =
reset.
>=20
> "after the device resets" ("he/she/it resets" since "reset" is a verb
> here).  But the following is shorter:
>=20
> s/after the device reset/after device reset/
>=20
> Here "reset" is a noun.
>=20
Nice, fixed.

> > +\item The driver MUST NOT transmit any requests to the device if the r=
eady
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
> > +\item The driver MUST identify and initialize all virtqueues.
> > +\item The driver MUST read the supported crypto services from bits of
> \field{crypto_services}.
> > +\item The driver MUST read the supported algorithms based on
> \field{crypto_services} field.
> > +\end{itemize*}
> > +
> > +\subsection{Device Operation}\label{sec:Device Types / Crypto Device /
> Device Operation}
> > +
> > +Requests can be transmitted by placing them in both the controlq and
> dataq.
>=20
> s/both the controlq and dataq/the controlq or dataq/
>=20
> This way it's clear that 1 request does not need to be placed into the
> controlq *and* the dataq.
>=20
OK, fixed.

> > +Requests consist of a queue-type specific header specifying among
> > +others the operation, and an operation specific payload.
> > +Where the payload are composed of operation parameter + output data +
> input data in general.
>=20
> "payload" is singular so it should be "the payload is" instead of "the
> payload are".  Here is a different way of phrasing this:
>=20
> The payload is generally composed of operation parameters, output data,
> and input data.
>=20
OK, it's better.=20

> > +Operation parameters are algorithm-specific parameters, output data is=
 the
> > +data that should be utilized in operations, and input data is equal to
> > +"operation result + result data".
> > +
> > +The device can support both session mode (See \ref{sec:Device Types /
> Crypto Device / Device Operation / Control Virtqueue / Session operation}=
) and
> stateless mode.
> > +As VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE feature bit is negotiated,
> the driver can use stateless mode for CIPHER service, otherwise it can on=
ly use
> session mode.
>=20
> "As" is used in the same way as "since" here.  "As" and "Since" are
> unconditional.  Using "if" or "when" is more appropriate because they
> are conditional.  They express that something applies when a condition
> is met:
>=20
> s/As/If the/
>=20
> I also added "the" because "VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE" is
> a
> member of a group of "feature bits" so a definite article is needed:
> https://en.wikipedia.org/wiki/Article_(grammar)#Definite_article
>=20
> (The alternative is to just say "If
> VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE is negotiated" without "feature
> bit" so that no definite article is needed.)
>=20
OK, Fixed.

> > +
> > +The header for controlq is as follows:
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
> > +    /* algo should be service-specific algorithms */
> > +    le32 algo;
> > +    le32 flag;
> > +    /* data virtqueue id */
> > +    le32 queue_id;
> > +};
> > +\end{lstlisting}
> > +
> > +The header of dataq is as follows:
>=20
> s/of/for/
>=20
Fixed.

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
>=20
> I'm surprised that a general field like session_id has
> algorithm-specific meaning.
>=20
Good catch, It's a typo because of copy.
Let me drop it.

> > +    le64 session_id;VIRTIO_CRYPTO_F_STATELESS_MODE
>=20
> ?
>=20
Sorry, It's a typo too. Drop it.

> > +#define VIRTIO_CRYPTO_FLAG_STATE_MODE 1
> > +#define VIRTIO_CRYPTO_FLAG_STATELESS_MODE 2
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
> > +device, such as session operations (See \ref{sec:Device Types / Crypto
> Device / Device Operation / Control Virtqueue / Session operation}).
> > +
> > +The request of controlq is as below:
>=20
> "controlq requests are as follows:"

Fixed.

Thanks,
-Gonglei
