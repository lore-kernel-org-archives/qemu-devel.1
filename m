Received: from eggs.gnu.org ([2001:4830:134:3::10]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6Gu3-0006dV-Dd
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6Gu0-0006NC-1R
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:34:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6Gty-0006LS-MP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:34:39 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 4 May 2017 13:33:36 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
In-Reply-To: <38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, Linqiangmin <linqiangmin@huawei.com>, Zhbzg <zhbzg@huawei.com>, "Chenshanxi (Eety Chen,
	Euler)" <eety.chen@huawei.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "lixiao (H)" <lixiao91@huawei.com>

Hi Halil,

>=20
>=20
> On 04/22/2017 08:23 AM, Gonglei wrote:
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
> >  acknowledgements.tex |    2 +
> >  content.tex          |    2 +
> >  virtio-crypto.tex    | 1309
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1313 insertions(+)
> >  create mode 100644 virtio-crypto.tex
> >
> > diff --git a/acknowledgements.tex b/acknowledgements.tex
> > index 53942b0..43b8a9b 100644
> > --- a/acknowledgements.tex
> > +++ b/acknowledgements.tex
> > @@ -26,6 +26,7 @@ Sasha Levin,	Oracle	\newline
> >  Sergey Tverdyshev,	Thales e-Security	\newline
> >  Stefan Hajnoczi,	Red Hat	\newline
> >  Tom Lyon,	Samya Systems, Inc.	\newline
> > +Lei Gong,  Huawei   \newline
> >  \end{oasistitlesection}
> >
> >  The following non-members have provided valuable feedback on this
> > @@ -44,4 +45,5 @@ Patrick Durusau,	Technical Advisory Board, OASIS
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
> > index 0000000..2708023
> > --- /dev/null
> > +++ b/virtio-crypto.tex
> > @@ -0,0 +1,1309 @@
> > +\section{Crypto Device}\label{sec:Device Types / Crypto Device}
> > +
> > +The virtio crypto device is a virtual cryptography device as well as a=
 kind of
>=20
> If I google for "cryptography device" there ain't much turning up.
> I wonder why? What is the difference between a cryptograpy device
> and a cryptographic accelerator?
>=20
IMHO they have the same meaning.

> > +virtual hardware accelerator for virtual machines. The encryption and
> > +decryption requests are placed in any of the data queues and are ultim=
ately
> handled by the
> > +backend crypto accelerators. The second kind of queue is the control q=
ueue
> used to create
>=20
> Could we leave out "backend" of the specification? What is
> the benefit of talking about the backend in this spec?
>=20
Ok, It's ok to me, let's drop the word.

> > +or destroy sessions for symmetric algorithms and will control some
> advanced
> > +features in the future. The virtio crypto device provides the followin=
g crypto
> > +services: CIPHER, MAC, HASH, and AEAD.
> > +
>=20
> I would prefer:
>=20
> The virtio crypto device is a virtual cryptography device as well as a
> virtual cryptographic accelerator. The virtio crypto device provides the
> following crypto services: CIPHER, MAC, HASH, and AEAD. Virtio crypto
> devices have a single control queue and at least one data queue. Crypto
> operation requests are placed into a data queue, and serviced by the
> device. Some crypto operation requests are only valid in the context of a
> session. The role of the control queue is facilitating control operation
> requests. Sessions management is realized with control operation
> requests.
>=20
It's indeed better. :)

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
>=20
>=20
> I find feature bit 0 redundant and bit confusing. We had a discussion
> in v15 and v16.
>=20
> Could you answer:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03214.html
> (Message-ID: <1fbe30cc-87ec-32bc-4c57-85f9b03b3034@linux.vnet.ibm.com>)
>=20
>=20
Please see my reply:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03186.html

The main reason is we should keep compatibility to pre-existing driver and
support some function that different services have different modes.
We have only one unique crypto request named structure virtio_crypto_op_dat=
a_req_mux.=20
Please continue to see the sepc, you'll find the truth.

>=20
> > +
> > +\subsection{Supported crypto services}\label{sec:Device Types / Crypto
> Device / Supported crypto services}
> > +
> > +The virtio crypto device provides the following crypto services: CIPHE=
R, MAC,
> HASH, and AEAD.
>=20
> How about
> The following crypto services are defined:
>=20
OK.

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
> > +The above constants are bit numbers, which tell the driver which crypt=
o
> services
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
>=20
> The above constants designate bits used to indicate the which of crypto
> services are
> offered by the device as described in .
>=20
Sorry, is "the which of " right usage?

>=20
> > +
> > +\subsubsection{CIPHER services}\label{sec:Device Types / Crypto Device=
 /
> Supported crypto services / CIPHER services}
>=20
> > +
> > +The following CIPHER algorithms are defined:
>=20
> The naming is a bit inconsistent. In the title you say
> services, here you say algorithms.
>=20
Because the CIPHER service uses the specific algorithm to provide services.

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
> > +\item As bit numbers, used to tell the driver which CIPHER algorithms
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, used to tell the device which CIPHER algorithm
> > +a crypto request from the driver requires, see \ref{sec:Device Types /=
 Crypto
> Device / Device Operation / Control Virtqueue / Session operation}.
> > +\end{enumerate}
> > +
> > +\subsubsection{HASH services}\label{sec:Device Types / Crypto Device /
> Supported crypto services / HASH services}
> > +
> > +The following HASH algorithms are defined:
>=20
> Same here.
>=20
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
> > +\item As bit numbers, used to tell the driver which HASH algorithms
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, used to tell the device which HASH algorithm
> > +a crypto request from the driver requires, see \ref{sec:Device Types /=
 Crypto
> Device / Device Operation / Control Virtqueue / Session operation}.
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
> > +\item As bit numbers, used to tell the driver which MAC algorithms
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, used to tell the device which MAC algorithm
> > +a crypto request from the driver requires, see \ref{sec:Device Types /=
 Crypto
> Device / Device Operation / Control Virtqueue / Session operation}.
> > +\end{enumerate}
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
> > +\item As bit numbers, used to tell the driver which AEAD algorithms
> > +are supported by the device, see \ref{sec:Device Types / Crypto Device=
 /
> Device configuration layout}.
> > +\item As values, used to tell the device what AEAD algorithm
> > +a crypto request from the driver requires, see \ref{sec:Device Types /=
 Crypto
> Device / Device Operation / Control Virtqueue / Session operation}.
> > +\end{enumerate}
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
>=20
> How about shortening these a little
> \item[\field{crypto_services}] crypto service offered (see \ref{
> sec:Device Types / Crypto Device / Supported crypto services})
>=20
> \item[\field{cipher_algo_l}]  CIPHER algorithms bits 0-31
>=20
> and so on
>=20
OK.

> > +
> > +\item[\field{cipher_algo_l}] is the low 32-bit mask which indicates th=
e
> CIPHER algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / CIPHER services}.
> > +
> > +\item[\field{cipher_algo_h}] is the high 32-bit mask which indicates t=
he
> CIPHER algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / CIPHER services}.
> > +
> > +\item[\field{hash_algo}] is a 32-bit mask which indicates the HASH
> algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / HASH services}.
> > +
> > +\item[\field{mac_algo_l}] is the low 32-bit mask which indicates the M=
AC
> algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / MAC services}.
> > +
> > +\item[\field{mac_algo_h}] is the high 32-bit mask which indicates the =
MAC
> algorithms supported by
> > +    the device, see \ref{sec:Device Types / Crypto Device / Supported
> crypto services  / MAC services}.
> > +
> > +\item[\field{aead_algo}] is a 32-bit mask which indicates the AEAD
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
>=20
> s/based on the \field{crypto_services} field/ for each service advertised=
 by
> \field{crypto_services}
>=20
OK.

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
> > +      is ready or not, and the driver MUST reread it after device rese=
t.
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
>=20
> Qouting a discussion from v15:
> """
> >
> >>> +The value of the \field{status} field is VIRTIO_CRYPTO_S_HW_READY or
> > ~VIRTIO_CRYPTO_S_HW_READY.
> >>
> >> Not entirely happy with this. What you want to say is reserved
> >> for future use, or? Would it make sense to have a general note
> >> -- in a similar fashion like for 'sizes are in bytes' -- for
> >> reserved for future use?
> >>
> >> One possible formulation would be:
> >>
> >> "In this specification, unless explicitly stated otherwise,
> >> fields and bits reserved for future use shall be zeroed out.
> >> Both the a device or a driver device and the driver should
> >> detect violations of this rule, and deny the requested
> >> operation in an appropriate way if possible."
> >
> > If we go with reserved-and-must-be-zero, we need to make rejecting
> > non-zero for reserved value a MUST, or we may run into problems later.
> >
> > In this case, I'd opt for a specific formulation, though; like
> >
> > "The \field{status} field can be either zero or have one or more flags
> > set. Valid flags are listed below."
> >
> > And then state that non-valid flags MUST NOT be set resp. MUST be
> > rejected in a normative statement.
> >
> Sounds good.
> """
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01596.html
>=20
> I can't find this. Did we agree on something else in the meanwhile?
>=20
Please see above description:

"""
\begin{description}
\item[\field{status}] is used to show whether the device is ready to work o=
r not, it can be either zero or have one or more flags
    Only one read-only bit (for the driver) is currently defined for the \f=
ield{status} field: VIRTIO_CRYPTO_S_HW_READY:
\begin{lstlisting}
#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
\end{lstlisting}
"""

>=20
> > +\end{itemize*}
> > +
>=20
> What about extensibility regarding "detailed algorithms"? Is the driver
> required ignore algorithms
> it does not "know about"? Should we reserve the not (yet) defined bits?
>=20
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
> > +Requests can be transmitted by placing them in the controlq or dataq.
> > +Requests consist of a queue-type specific header specifying among
> > +others the operation, and an operation specific payload.
> > +The payload is generally composed of operation parameters, output data=
,
> and input data.
> > +Operation parameters are algorithm-specific parameters, output data is=
 the
> > +data that should be utilized in operations, and input data is equal to
> > +"operation result + result data".
> > +
>=20
>=20
> > +The device can support both session mode (See \ref{sec:Device Types /
> Crypto Device / Device Operation / Control Virtqueue / Session operation}=
) and
> stateless mode.
> > +If VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE is negotiated, the driver
> can use stateless mode for CIPHER service, otherwise it can only use sess=
ion
> mode.
>=20
> How about:
> In stateless mode all operation parameters are supplied as a part
> of each request, while in session mode, some or all operation parameters
> are managed within the session. Stateless mode is guarded by
> feature bits 0-4 on a service level. If stateless mode is negotiated
> for some service, the service is available both in session and
> stateless mode; otherwise it's only available in session mode.
>=20
Good.

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
> > +The header for dataq is as follows:
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
> > +    le64 session_id;
> > +#define VIRTIO_CRYPTO_FLAG_STATE_MODE 1
>=20
> This name ain't consistent with the name session mode
> used in the text. What's the purpose of this flag
> anyway (a single bit should suffice)
>=20
Nice catch, we should name it VIRTIO_CRYPTO_FLAG_SESSION_MODE.
This flag is used to identify a the request is session mode or not. It's
true a single bit is enough.

> > +#define VIRTIO_CRYPTO_FLAG_STATELESS_MODE 2
> > +    /* control flag to control the request */
> > +    le32 flag;
> > +    le32 padding;
> > +};
> > +\end{lstlisting}
>=20
> Will continue from here.
>=20
Thanks!

> [..]

Thanks,
-Gonglei
