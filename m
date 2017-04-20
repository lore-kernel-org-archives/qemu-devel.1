Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1BwW-0000iC-Pm
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1BwR-0004HZ-Kk
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:16:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3382
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1BwP-0004Al-Pb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:16:11 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 20 Apr 2017 13:11:34 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA237591@DGGEMA505-MBS.china.huawei.com>
References: <1492074674-124192-1-git-send-email-arei.gonglei@huawei.com>
	<1492074674-124192-2-git-send-email-arei.gonglei@huawei.com>
	<20170420100419.GA28129@stefanha-x1.localdomain>
In-Reply-To: <20170420100419.GA28129@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v17 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, Zhbzg <zhbzg@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, Maoningning <maoningning@huawei.com>

Hi Stefan,


>
> Subject: Re: [virtio-dev] [PATCH v17 1/2] virtio-crypto: Add virtio crypt=
o device
> specification
>=20
> On Thu, Apr 13, 2017 at 05:11:13PM +0800, Gonglei wrote:
>=20
> More review, not done yet.
>=20
Thanks a lot!

[snip]

> > +The device can set the operation status as follows: VIRTIO_CRYPTO_OK:
> success;
> > +VIRTIO_CRYPTO_ERR: failure or device error; VIRTIO_CRYPTO_NOTSUPP:
> not supported;
> > +VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto
> operations.
> > +
> > +\begin{lstlisting}
> > +enum VIRITO_CRYPTO_STATUS {
>=20
> s/VIRITO/VIRTIO/
>=20
Oops, good catch. Fortunately I hadn't define this name in source code.
Will fix it in the next version.

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
> > +struct virtio_crypto_op_ctrl_req is the only loading form of controlq
> requests.
>=20
> Does "loading" mean "allowed"?
>=20
> "struct virtio_crypto_op_ctrl_req is the only allowed control request"
>=20
Hmm.. It's better.

> > +The header is the general header, and the union is of the algorithm-sp=
ecific
> type,
> > +which is set by the driver. All the properties in the union are shown =
as
> follows.
> > +
> > +\paragraph{Session operation}\label{sec:Device Types / Crypto Device /
> Device Operation / Control Virtqueue / Session operation}
> > +
> > +The symmetric algorithms involve the concept of sessions. A session is=
 a
> > +handle which describes the cryptographic parameters to be applied to
> > +a number of buffers. The data within a session handle includes:
> > +
> > +\begin{enumerate}
> > +\item The operation (CIPHER, HASH/MAC or both, and if both, the order =
in
> > +      which the algorithms should be applied).
> > +\item The CIPHER set data, including the CIPHER algorithm and mode,
> > +      the key and its length, and the direction (encryption or decrypt=
ion).
> > +\item The HASH/MAC set data, including the HASH algorithm or MAC
> algorithm,
> > +      and hash result length (to allow for truncation).
> > +\begin{itemize*}
> > +\item Authenticated mode can refer to MAC, which requires that the key
> and
> > +      its length are also specified.
> > +\item For nested mode, the inner and outer prefix data and length are
> specified,
> > +      as well as the outer HASH algorithm.
> > +\end{itemize*}
> > +\end{enumerate}
> > +
> > +The following structure stores the result of session creation set by t=
he
> device:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_session_input {
> > +    /* Device-writable part */
> > +    le64 session_id;
> > +    le32 status;
> > +    le32 padding;
> > +};
> > +\end{lstlisting}
> > +
> > +A request to destroy a session includes the following information:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_destroy_session_req {
> > +    /* Device-readable part */
> > +    le64  session_id;
> > +    /* Device-writable part */
> > +    le32  status;
> > +    le32  padding;
> > +};
> > +\end{lstlisting}
> > +
> > +\subparagraph{Session operation: HASH session}\label{sec:Device Types =
/
> Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:=
 HASH
> session}
> > +
> > +The request of HASH session is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_hash_session_para {
> > +    /* See VIRTIO_CRYPTO_HASH_* above */
> > +    le32 algo;
> > +    /* hash result length */
> > +    le32 hash_result_len;
> > +};
> > +struct virtio_crypto_hash_create_session_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_hash_session_para para;
> > +    /* Device-writable part */
> > +    struct virtio_crypto_session_input input;
> > +};
> > +\end{lstlisting}
> > +
> > +\subparagraph{Session operation: MAC session}\label{sec:Device Types /
> Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:=
 MAC
> session}
> > +
> > +The request of MAC session is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_mac_session_para {
> > +    /* See VIRTIO_CRYPTO_MAC_* above */
> > +    le32 algo;
> > +    /* hash result length */
> > +    le32 hash_result_len;
> > +    /* length of authenticated key */
> > +    le32 auth_key_len;
> > +    le32 padding;
> > +};
> > +
> > +struct virtio_crypto_mac_create_session_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_mac_session_para para;
> > +    /* The authenticated key */
> > +    u8 auth_key[auth_key_len];
> > +
> > +    /* Device-writable part */
> > +    struct virtio_crypto_session_input input;
> > +};
> > +\end{lstlisting}
> > +
> > +\subparagraph{Session operation: Symmetric algorithms
> session}\label{sec:Device Types / Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:
> Symmetric algorithms session}
> > +
> > +The request of symmetric session includes two parts, CIPHER algorithms
> and chain
> > +algorithms (chaining CIPHER and HASH/MAC). The request for CIPHER
> session is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_cipher_session_para {
> > +    /* See VIRTIO_CRYPTO_CIPHER* above */
> > +    le32 algo;
> > +    /* length of key */
> > +    le32 keylen;
> > +#define VIRTIO_CRYPTO_OP_ENCRYPT  1
> > +#define VIRTIO_CRYPTO_OP_DECRYPT  2
> > +    /* encryption or decryption */
> > +    le32 op;
> > +    le32 padding;
> > +};
> > +
> > +struct virtio_crypto_cipher_session_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_cipher_session_para para;
> > +    /* The cipher key */
> > +    u8 cipher_key[keylen];
> > +
> > +    /* Device-writable part */
> > +    struct virtio_crypto_session_input input;
> > +};
> > +\end{lstlisting}
> > +
> > +The request for algorithm chaining is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_alg_chain_session_para {
> > +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER
> 1
> > +#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH
> 2
> > +    le32 alg_chain_order;
> > +/* Plain hash */
> > +#define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
> > +/* Authenticated hash (mac) */
> > +#define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
> > +/* Nested hash */
> > +#define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
> > +    le32 hash_mode;
> > +    struct virtio_crypto_cipher_session_para cipher_param;
> > +    union {
> > +        struct virtio_crypto_hash_session_para hash_param;
> > +        struct virtio_crypto_mac_session_para mac_param;
> > +    } u;
> > +    /* length of the additional authenticated data (AAD) in bytes */
> > +    le32 aad_len;
> > +    le32 padding;
> > +};
> > +
> > +struct virtio_crypto_alg_chain_session_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_alg_chain_session_para para;
> > +    /* The cipher key */
> > +    u8 cipher_key[keylen];
> > +    /* The authenticated key */
> > +    u8 auth_key[auth_key_len];
> > +
> > +    /* Device-writable part */
> > +    struct virtio_crypto_session_input input;
> > +};
> > +\end{lstlisting}
> > +
> > +The request for symmetric algorithm is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_sym_create_session_req {
> > +    union {
> > +        struct virtio_crypto_cipher_session_req cipher;
> > +        struct virtio_crypto_alg_chain_session_req chain;
> > +    } u;
> > +
> > +    /* Device-readable part */
> > +
> > +/* No operation */
> > +#define VIRTIO_CRYPTO_SYM_OP_NONE  0
>=20
> This operation is not defined by the spec.  QEMU returns
> VIRTIO_CRYPTO_NOTSUPP.
>=20
> The spec should cover the behavior of every constant.  Otherwise there
> is a risk that implementations of the spec will differ.
>=20
OK, I'll add explanation for this operation type. It means don't do cipher
operations for a request, the device can directly return results.

> > +/* Cipher only operation on the data */
> > +#define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
> > +/* Chain any cipher with any hash or mac operation. The order
> > +   depends on the value of alg_chain_order param */
> > +#define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
> > +    le32 op_type;
> > +    le32 padding;
> > +};
> > +\end{lstlisting}
> > +
> > +\subparagraph{Session operation: AEAD session}\label{sec:Device Types =
/
> Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:=
 AEAD
> session}
> > +
> > +The request for AEAD session is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_aead_session_para {
> > +    /* See VIRTIO_CRYPTO_AEAD_* above */
> > +    le32 algo;
> > +    /* length of key */
> > +    le32 key_len;
> > +    /* Authentication tag length */
> > +    le32 tag_len;
> > +    /* The length of the additional authenticated data (AAD) in bytes =
*/
> > +    le32 aad_len;
> > +    /* encryption or decryption, See above VIRTIO_CRYPTO_OP_* */
> > +    le32 op;
> > +    le32 padding;
> > +};
> > +
> > +struct virtio_crypto_aead_create_session_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_aead_session_para para;
> > +    u8 key[key_len];
> > +
> > +    /* Device-writeable part */
> > +    struct virtio_crypto_session_input input;
> > +};
> > +\end{lstlisting}
> > +
> > +\drivernormative{\subparagraph}{Session operation: create session}{Dev=
ice
> Types / Crypto Device / Device Operation / Control Virtqueue / Session
> operation / Session operation: create session}
> > +
> > +\begin{itemize*}
> > +\item The driver MUST set the control general header and corresponding
> properties of the union in structure virtio_crypto_op_ctrl_req. See
> \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqu=
eue}.
> > +\item The driver MUST set \field{opcode} field based on service type: =
CIPHER,
> HASH, MAC, or AEAD.
>=20
> Missing definite article:
>=20
> "MUST set the \field{opcode} field"
>=20
> > +\item The driver MUST set \field{queue_id} field to show used dataq.
>=20
> More missing definite articles:
>=20
> "MUST set the \field{queue_id} field"
>=20
> (This applies to all "MUST set \field{X} field" below too)
>=20
OK, will do.

> "to identify the dataq"
>=20
> > +\end{itemize*}
> > +
> > +\devicenormative{\subparagraph}{Session operation: create session}{Dev=
ice
> Types / Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:
> create session}
> > +
> > +\begin{itemize*}
> > +\item The device MUST set \field{session_id} field as a session identi=
fier
> return to the driver when the device finishes processing session creation=
.
>=20
> The phrase is "set X to Y" instead of "set X as Y":
>=20
> s/as a session identifier return to the driver/to a unique session
> identifier/
>=20
> I dropped the "return to the driver" concept since it should be clear
> from the context that the device is filling out fields that the driver
> reads.
>=20
OK. I agree.

> > +\item The device MUST set \field{status} field to one of the values of=
 enum
> VIRITO_CRYPTO_STATUS.
>=20
> VIRTIO typo.
>=20
Fixed.

> > +\end{itemize*}
> > +
> > +\drivernormative{\subparagraph}{Session operation: destroy
> session}{Device Types / Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:
> destroy session}
> > +
> > +\begin{itemize*}
> > +\item The driver MUST set \field{opcode} field based on service type: =
CIPHER,
> HASH, MAC, or AEAD.
> > +\item The driver MUST set the \field{session_id} to a valid value whic=
h
> assigned by the device when a session is created.
>=20
> An explanation is beyond my grammar knowledge :) but the following
> sounds correct:
>=20
> "to a valid value assigned by the device when the session was created"
>=20
Sounds good. ;)

> > +\end{itemize*}
> > +
> > +\devicenormative{\subparagraph}{Session operation: destroy
> session}{Device Types / Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:
> destroy session}
> > +
> > +\begin{itemize*}
> > +\item The device MUST set \field{status} field to one of the values of=
 enum
> VIRITO_CRYPTO_STATUS.
>=20
> VIRTIO typo.
>=20
Fixed.

> > +\end{itemize*}
> > +
> > +\subsubsection{Data Virtqueue}\label{sec:Device Types / Crypto Device =
/
> Device Operation / Data Virtqueue}
> > +
> > +The driver uses the data virtqueue to transmit the requests of crypto
> operation to the device,
>=20
> s/transmit the requests of crypto operation/to transmit crypto operation
> requests/
>=20
> > +and completes the data plane operations (such as crypto operation).
>=20
> "data plane operations" is plural so "such as crypto operation" must
> also be plural:
>=20
> "such as crypto operations"
>=20
Er, I should drop all 'data plane' phrases as Halil's suggestion, this is a=
 leak.

> > +
> > +The session mode request of dataq is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_op_data_req {
> > +    struct virtio_crypto_op_header header;
> > +
> > +    union {
> > +        struct virtio_crypto_sym_data_req   sym_req;
> > +        struct virtio_crypto_hash_data_req  hash_req;
> > +        struct virtio_crypto_mac_data_req   mac_req;
> > +        struct virtio_crypto_aead_data_req  aead_req;
> > +    } u;
> > +};
> > +\end{lstlisting}
> > +
> > +The request of dataq, mixing both session and stateless mode is as fol=
lows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_op_data_req_mux {
> > +    struct virtio_crypto_op_header header;
> > +
> > +    union {
> > +        struct virtio_crypto_sym_data_req   sym_req;
> > +        struct virtio_crypto_hash_data_req  hash_req;
> > +        struct virtio_crypto_mac_data_req   mac_req;
> > +        struct virtio_crypto_aead_data_req  aead_req;
> > +        struct virtio_crypto_sym_data_req_stateless
> sym_stateless_req;
> > +        struct virtio_crypto_hash_data_req_stateless
> hash_stateless_req;
> > +        struct virtio_crypto_mac_data_req_stateless
> mac_stateless_req;
> > +        struct virtio_crypto_aead_data_req_stateless
> aead_stateless_req;
> > +    } u;
> > +};
> > +\end{lstlisting}
> > +
> > +The header is the general header and the union is of the algorithm-spe=
cific
> type,
> > +which is set by the driver. All properties in the union are shown as f=
ollows.
> > +
> > +There is a unified input header structure for all crypto services.
> > +
> > +The structure is defined as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_inhdr {
> > +    u8 status;
> > +};
> > +\end{lstlisting}
> > +
> > +\subsubsection{HASH Service Operation}\label{sec:Device Types / Crypto
> Device / Device Operation / HASH Service Operation}
> > +
> > +The session mode request of HASH service:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_hash_para {
> > +    /* length of source data */
> > +    le32 src_data_len;
> > +    /* hash result length */
> > +    le32 hash_result_len;
> > +};
> > +
> > +struct virtio_crypto_hash_data_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_hash_para para;
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +
> > +    /* Device-writable part */
> > +    /* Hash result data */
> > +    u8 hash_result[hash_result_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +Each data request uses virtio_crypto_hash_data_req structure to store
> information
> > +used to run the HASH operations.
> > +
> > +The information includes the hash parameters stored by \field{para}, o=
utput
> data and input data.
> > +The output data here includes the source data and the input data inclu=
des
> the hash result data used to save the results of the HASH operations.
> > +\field{inhdr} stores status of executing the HASH operations.
> > +
> > +The stateless mode request of HASH service is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_hash_para_statelesss {
> > +    struct {
> > +        /* See VIRTIO_CRYPTO_HASH_* above */
> > +        le32 algo;
> > +    } sess_para;
> > +
> > +    /* length of source data */
> > +    le32 src_data_len;
> > +    /* hash result length */
> > +    le32 hash_result_len;
> > +    le32 reserved;
> > +};
> > +struct virtio_crypto_hash_data_req_stateless {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_hash_para_stateless para;
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +
> > +    /* Device-writable part */
> > +    /* Hash result data */
> > +    u8 hash_result[hash_result_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +\drivernormative{\paragraph}{HASH Service Operation}{Device Types /
> Crypto Device / Device Operation / HASH Service Operation}
> > +
> > +\begin{itemize*}
> > +\item If the driver uses the session mode, then the driver MUST set th=
e
> \field{session_id} in struct virtio_crypto_op_header
> > +      to a valid value which assigned by the device when a session is
> created.
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap cryp=
to
> requests. Otherwise, the driver MUST use the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is
> negotiated, 1) if the driver use the stateless mode, then the driver MUST=
 set
> \field{flag} field in struct virtio_crypto_op_header
> > +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set fields in
> struct virtio_crypto_hash_para_statelession.sess_para, 2) if the driver s=
till
> uses the session mode, then the driver MUST set \field{flag} field in str=
uct
> virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
> > +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_he=
ader
> to VIRTIO_CRYPTO_HASH.
> > +\end{itemize*}
> > +
> > +\devicenormative{\paragraph}{HASH Service Operation}{Device Types /
> Crypto Device / Device Operation / HASH Service Operation}
> > +
> > +\begin{itemize*}
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto
> requests. Otherwise, the device MUST parse the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is
> negotiated, the device MUST parse \field{flag} field in struct
> virtio_crypto_op_header in order to decide which mode the driver uses.
> > +\item The device MUST copy the results of HASH operations to the
> hash_result[] if HASH operations success.
> > +\item The device MUST set \field{status} in struct virtio_crypto_inhdr=
 to one
> of the values of enum VIRITO_CRYPTO_STATUS.
>=20
> VIRTIO typo.
>=20
Fixed.

> > +\end{itemize*}
> > +
> > +\subsubsection{MAC Service Operation}\label{sec:Device Types / Crypto
> Device / Device Operation / MAC Service Operation}
> > +
> > +The session mode request of MAC service is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_mac_para {
> > +    struct virtio_crypto_hash_para hash;
> > +};
> > +
> > +struct virtio_crypto_mac_data_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_mac_para para;
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +
> > +    /* Device-writable part */
> > +    /* Hash result data */
> > +    u8 hash_result[hash_result_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +Each data request uses virtio_crypto_mac_data_req structure to store
> information
> > +used to run the MAC operations.
> > +
> > +The information includes the hash parameters stored by \field{para}, o=
utput
> data and input data.
> > +The output data here includes the source data and the input data inclu=
des
> the hash result data used to save the results of the MAC operations.
> > +\field{inhdr} stores status of executing the MAC operations.
> > +
> > +The stateless mode request of MAC service:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_mac_para_stateless {
> > +    struct {
> > +        /* See VIRTIO_CRYPTO_MAC_* above */
> > +        le32 algo;
> > +        /* length of authenticated key */
> > +        le32 auth_key_len;
> > +    } sess_para;
> > +
> > +    /* length of source data */
> > +    le32 src_data_len;
> > +    /* hash result length */
> > +    le32 hash_result_len;
> > +};
> > +
> > +struct virtio_crypto_mac_data_req_stateless {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_mac_para_stateless para;
> > +    /* The authenticated key */
> > +    u8 auth_key[auth_key_len];
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +
> > +    /* Device-writable part */
> > +    /* Hash result data */
> > +    u8 hash_result[hash_result_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +\drivernormative{\paragraph}{MAC Service Operation}{Device Types /
> Crypto Device / Device Operation / MAC Service Operation}
> > +
> > +\begin{itemize*}
> > +\item If the driver uses the session mode, then the driver MUST set th=
e
> \field{session_id} in struct virtio_crypto_op_header
> > +      to a valid value which assigned by the device when a session is
> created.
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap cryp=
to
> requests. Otherwise, the driver MUST use the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_MAC_STATELESS_MODE feature bit is
> negotiated, 1) if the driver use the stateless mode, then the driver MUST=
 set
> \field{flag} field in struct virtio_crypto_op_header
> > +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set fields in
> struct virtio_crypto_mac_para_statelession.sess_para, 2) if the driver st=
ill uses
> the session mode, then the driver MUST set \field{flag} field in struct
> virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
> > +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_he=
ader
> to VIRTIO_CRYPTO_MAC.
> > +\end{itemize*}
> > +
> > +\devicenormative{\paragraph}{MAC Service Operation}{Device Types /
> Crypto Device / Device Operation / MAC Service Operation}
> > +
> > +\begin{itemize*}
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto
> requests. Otherwise, the device MUST parse the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_MAC_STATELESS_MODE feature bit is
> negotiated, the device MUST parse \field{flag} field in struct
> virtio_crypto_op_header in order to decide which mode the driver uses.
> > +\item The device MUST copy the results of MAC operations to the
> hash_result[] if HASH operations success.
> > +\item The device MUST set \field{status} in struct virtio_crypto_inhdr=
 to one
> of the values of enum VIRITO_CRYPTO_STATUS.
>=20
> VIRTIO typo.
>=20
Fixed.

> > +\end{itemize*}
> > +
> > +\subsubsection{Symmetric algorithms Operation}\label{sec:Device Types =
/
> Crypto Device / Device Operation / Symmetric algorithms Operation}
> > +
> > +The session mode request of plain CIPHER service is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_cipher_para {
> > +    /*
> > +     * Byte Length of valid IV/Counter data pointed to by the below iv=
 data.
> > +     *
> > +     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, =
or for
> > +     *   SNOW3G in UEA2 mode, this is the length of the IV (which
> > +     *   must be the same as the block length of the cipher).
> > +     * For block ciphers in CTR mode, this is the length of the counte=
r
> > +     *   (which must be the same as the block length of the cipher).
> > +     */
> > +    le32 iv_len;
> > +    /* length of source data */
> > +    le32 src_data_len;
> > +    /* length of destination data */
> > +    le32 dst_data_len;
> > +    le32 padding;
> > +};
> > +
> > +struct virtio_crypto_cipher_data_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_cipher_para para;
> > +    /*
> > +     * Initialization Vector or Counter data.
> > +     *
> > +     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, =
or for
> > +     *   SNOW3G in UEA2 mode, this is the Initialization Vector (IV)
> > +     *   value.
> > +     * For block ciphers in CTR mode, this is the counter.
> > +     * For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-20=
07.
> > +     *
> > +     * The IV/Counter will be updated after every partial cryptographi=
c
> > +     * operation.
> > +     */
> > +    u8 iv[iv_len];
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +
> > +    /* Device-writable part */
> > +    /* Destination data */
> > +    u8 dst_data[dst_data_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +The session mode request of algorithm chaining is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_alg_chain_data_para {
> > +    le32 iv_len;
> > +    /* Length of source data */
> > +    le32 src_data_len;
> > +    /* Length of destination data */
> > +    le32 dst_data_len;
> > +    /* Starting point for cipher processing in source data */
> > +    le32 cipher_start_src_offset;
> > +    /* Length of the source data that the cipher will be computed on *=
/
> > +    le32 len_to_cipher;
> > +    /* Starting point for hash processing in source data */
> > +    le32 hash_start_src_offset;
> > +    /* Length of the source data that the hash will be computed on */
> > +    le32 len_to_hash;
> > +    /* Length of the additional auth data */
> > +    le32 aad_len;
> > +    /* Length of the hash result */
> > +    le32 hash_result_len;
> > +    le32 reserved;
> > +};
> > +
> > +struct virtio_crypto_alg_chain_data_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_alg_chain_data_para para;
> > +    /* Initialization Vector or Counter data */
> > +    u8 iv[iv_len];
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +    /* Additional authenticated data if exists  */
> > +    u8 aad[aad_len];
> > +
> > +    /* Device-writable part */
> > +    /* Destination data */
> > +    u8 dst_data[dst_data_len];
> > +    /* Hash result data */
> > +    u8 hash_result[hash_result_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +The session mode request of symmetric algorithm is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_sym_data_req {
> > +    union {
> > +        struct virtio_crypto_cipher_data_req cipher;
> > +        struct virtio_crypto_alg_chain_data_req chain;
> > +    } u;
> > +
> > +    /* Device-readable part */
> > +
> > +    /* See above VIRTIO_CRYPTO_SYM_OP_* */
> > +    le32 op_type;
> > +    le32 padding;
> > +};
> > +\end{lstlisting}
> > +
> > +Each data request uses virtio_crypto_sym_data_req structure to store
> information
> > +used to run the CIPHER operations.
> > +
> > +The information includes the cipher parameters stored by \field{para},
> output data and input data.
> > +In the first virtio_crypto_cipher_para structure, \field{iv_len} speci=
fies the
> length of the initialization vector or counter,
> > +\field{src_data_len} specifies the length of the source data, and
> \field{dst_data_len} specifies the
> > +length of the destination data.
> > +For plain CIPHER operations, the output data here includes the IV/Coun=
ter
> data and source data, and the input data includes the destination data us=
ed to
> save the results of the CIPHER operations.
> > +
> > +For algorithms chain, the output data here includes the IV/Counter dat=
a,
> source data and additional authenticated data if exists.
> > +The input data includes both destination data and hash result data use=
d to
> store the results of the HASH/MAC operations.
> > +\field{inhdr} stores status of executing the crypto operations.
> > +
> > +The stateless mode request of plain CIPHER service is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_cipher_para_stateless {
> > +    struct {
> > +        /* See VIRTIO_CRYPTO_CIPHER* above */
> > +        le32 algo;
> > +        /* length of key */
> > +        le32 keylen;
> > +
> > +        /* See VIRTIO_CRYPTO_OP_* above */
> > +        le32 op;
> > +    } sess_para;
> > +
> > +    /*
> > +     * Byte Length of valid IV/Counter data pointed to by the below iv=
 data.
> > +     */
> > +    le32 iv_len;
> > +    /* length of source data */
> > +    le32 src_data_len;
> > +    /* length of destination data */
> > +    le32 dst_data_len;
> > +};
> > +
> > +struct virtio_crypto_cipher_data_req_stateless {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_cipher_para_stateless para;
> > +    /* The cipher key */
> > +    u8 cipher_key[keylen];
> > +
> > +    /* Initialization Vector or Counter data. */
> > +    u8 iv[iv_len];
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +
> > +    /* Device-writable part */
> > +    /* Destination data */
> > +    u8 dst_data[dst_data_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +The stateless mode request of algorithm chaining is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_alg_chain_data_para_stateless {
> > +    struct {
> > +        /* See VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_* above */
> > +        le32 alg_chain_order;
> > +        /* length of the additional authenticated data in bytes */
> > +        le32 aad_len;
> > +
> > +        struct {
> > +            /* See VIRTIO_CRYPTO_CIPHER* above */
> > +            le32 algo;
> > +            /* length of key */
> > +            le32 keylen;
> > +            /* See VIRTIO_CRYPTO_OP_* above */
> > +            le32 op;
> > +        } cipher;
> > +
> > +        struct {
> > +            /* See VIRTIO_CRYPTO_HASH_* or VIRTIO_CRYPTO_MAC_*
> above */
> > +            le32 algo;
> > +            /* length of authenticated key */
> > +            le32 auth_key_len;
> > +            /* See VIRTIO_CRYPTO_SYM_HASH_MODE_* above */
> > +            le32 hash_mode;
> > +        } hash;
> > +    } sess_para;
> > +
> > +    le32 iv_len;
> > +    /* Length of source data */
> > +    le32 src_data_len;
> > +    /* Length of destination data */
> > +    le32 dst_data_len;
> > +    /* Starting point for cipher processing in source data */
> > +    le32 cipher_start_src_offset;
> > +    /* Length of the source data that the cipher will be computed on *=
/
> > +    le32 len_to_cipher;
> > +    /* Starting point for hash processing in source data */
> > +    le32 hash_start_src_offset;
> > +    /* Length of the source data that the hash will be computed on */
> > +    le32 len_to_hash;
> > +    /* Length of the additional auth data */
> > +    le32 aad_len;
> > +    /* Length of the hash result */
> > +    le32 hash_result_len;
> > +    le32 reserved;
> > +};
> > +
> > +struct virtio_crypto_alg_chain_data_req_stateless {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_alg_chain_data_para_stateless para;
> > +    /* The cipher key */
> > +    u8 cipher_key[keylen];
> > +    /* The auth key */
> > +    u8 auth_key[auth_key_len];
> > +    /* Initialization Vector or Counter data */
> > +    u8 iv[iv_len];
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +    /* Additional authenticated data if exists  */
> > +    u8 aad[aad_len];
> > +
> > +    /* Device-writable part */
> > +    /* Destination data */
> > +    u8 dst_data[dst_data_len];
> > +    /* Hash result data */
> > +    u8 hash_result[hash_result_len];
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +The stateless mode request of symmetric algorithm is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_sym_data_req_stateless {
> > +    union {
> > +        struct virtio_crypto_cipher_data_req_stateless cipher;
> > +        struct virtio_crypto_alg_chain_data_req_stateless chain;
> > +    } u;
> > +
> > +    /* Device-readable part */
> > +
> > +    /* See above VIRTIO_CRYPTO_SYM_OP_* */
> > +    le32 op_type;
> > +    le32 padding;
> > +};
> > +\end{lstlisting}
> > +
> > +\drivernormative{\paragraph}{Symmetric algorithms Operation}{Device
> Types / Crypto Device / Device Operation / Symmetric algorithms Operation=
}
> > +
> > +\begin{itemize*}
> > +\item If the driver uses the session mode, then the driver MUST set th=
e
> \field{session_id} in struct virtio_crypto_op_header
> > +      to a valid value which assigned by the device when a session is
> created.
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap cryp=
to
> requests. Otherwise, the driver MUST use the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE feature bit is
> negotiated, 1) if the driver use the stateless mode, then the driver MUST=
 set
> \field{flag} field in struct virtio_crypto_op_header
> > +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set fields in
> struct virtio_crypto_cipher_para_statelession.sess_para or struct
> virtio_crypto_alg_chain_data_para_stateless.sess_para, 2) if the driver s=
till
> uses the session mode, then the driver MUST set \field{flag} field in str=
uct
> virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
> > +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_he=
ader
> to VIRTIO_CRYPTO_CIPHER_ENCRYPT or VIRTIO_CRYPTO_CIPHER_DECRYPT.
> > +\item The driver MUST specify the fields of struct
> virtio_crypto_cipher_data_req in struct virtio_crypto_sym_data_req if the
> request is based on VIRTIO_CRYPTO_SYM_OP_CIPHER.
> > +\item The driver MUST specify the fields of both struct
> virtio_crypto_cipher_data_req and struct virtio_crypto_mac_data_req in st=
ruct
> virtio_crypto_sym_data_req if the request
> > +      is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING type
> and in the VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
> > +\end{itemize*}
> > +
> > +\devicenormative{\paragraph}{Symmetric algorithms Operation}{Device
> Types / Crypto Device / Device Operation / Symmetric algorithms Operation=
}
> > +
> > +\begin{itemize*}
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto
> requests. Otherwise, the device MUST parse the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE feature bit is
> negotiated, the device MUST parse \field{flag} field in struct
> virtio_crypto_op_header in order to decide which mode the driver uses.
> > +\item The device MUST parse the virtio_crypto_sym_data_req based on th=
e
> \field{opcode} in general header.
> > +\item The device SHOULD only parse fields of struct
> virtio_crypto_cipher_data_req in struct virtio_crypto_sym_data_req if the
> request is VIRTIO_CRYPTO_SYM_OP_CIPHER type.
> > +\item The device MUST parse fields of both struct
> virtio_crypto_cipher_data_req and struct virtio_crypto_mac_data_req in st=
ruct
> virtio_crypto_sym_data_req if the request
> > +      is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING
> operation type and in the VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH mode.
> > +\item The device MUST copy the result of cryptographic operation to th=
e
> dst_data[] in both plain CIPHER mode and algorithms chain mode.
> > +\item The device MUST check the \field{para}.\field{add_len} is bigger=
 than 0
> before parse the additional authenticated data in plain algorithms chain =
mode.
> > +\item The device MUST copy the result of HASH/MAC operation to the
> hash_result[] is of the VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING
> type.
> > +\item The device MUST set the \field{status} field in struct
> virtio_crypto_inhdr to one of the values of enum VIRITO_CRYPTO_STATUS.
>=20
> VIRTIO typo
>=20
Fixed.

> > +\end{itemize*}
> > +
> > +\paragraph{Steps of Operation}\label{sec:Device Types / Crypto Device =
/
> Device Operation / Symmetric algorithms Operation / Steps of Operation}
> > +
> > +\subparagraph{Step1: Create session}\label{sec:Device Types / Crypto
> Device / Device Operation / Symmetric algorithms Operation / Steps of
> Operation / Step1: Create session on session mode}
> > +
> > +\begin{enumerate}
> > +\item The driver specifies information in struct virtio_crypto_op_ctrl=
_req,
> including the algorithm name, key, keylen etc;
> > +\item The driver adds the request of session creation into the control=
q's
> Vring Descriptor Table;
> > +\item The driver kicks the device;
> > +\item The device receives the request from controlq;
> > +\item The device parses information about the request, and determines =
the
> information concerning the backend crypto accelerator;
> > +\item The device packs information based on the APIs of the backend cr=
ypto
> accelerator;
> > +\item The device invokes the session creation APIs of the backend cryp=
to
> accelerator to create a session;
> > +\item The device returns the session id to the driver.
> > +\end{enumerate}
> > +
> > +\subparagraph{Step2: Execute cryptographic operation}\label{sec:Device
> Types / Crypto Device / Device Operation / Symmetric algorithms Operation=
 /
> Steps of Operation / Step2: Execute cryptographic operation}
> > +
> > +\begin{enumerate}
> > +\item The driver specifies information in struct virtio_crypto_op_data=
_req,
> including struct virtio_crypto_op_header and struct
> virtio_crypto_sym_data_req, see \ref{sec:Device Types / Crypto Device /
> Device
> > +      Operation / Symmetric algorithms Operation};
> > +\item The driver adds the request for cryptographic operation into the
> dataq's Vring Descriptor Table;
> > +\item The driver kicks the device (Or the device actively polls the da=
taq's
> Vring Descriptor Table);
> > +\item The device receives the request from dataq;
> > +\item The device parses information about the request, and determines =
the
> identification information for the backend crypto accelerator. For exampl=
e,
> converting guest physical addresses to host physical addresses;
> > +\item The device packs identification information based on the API of =
the
> backend crypto accelerator;
> > +\item The device invokes the cryptographic APIs of the backend crypto
> accelerator;
> > +\item The backend crypto accelerator executes the cryptographic operat=
ion
> implicitly;
> > +\item The device receives the cryptographic results from the backend c=
rypto
> accelerator (synchronous or asynchronous);
> > +\item The device sets the \field{status} in struct virtio_crypto_inhdr=
;
> > +\item The device updates and flushes the Used Ring to return the
> cryptographic results to the driver;
> > +\item The device notifies the driver (Or the driver actively polls the=
 dataq's
> Used Ring);
> > +\item The driver saves the cryptographic results.
> > +\end{enumerate}
> > +
> > +\begin{note}
> > +\begin{itemize*}
> > +\item For better performance, the device should by preference use vhos=
t
> scheme (user space or kernel space)
> > +      as the backend crypto accelerator in the real production
> environment.
> > +\end{itemize*}
> > +\end{note}
> > +
> > +\subsubsection{AEAD Service Operation}\label{sec:Device Types / Crypto
> Device / Device Operation / AEAD Service Operation}
> > +
> > +The session mode request of symmetric algorithm is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_aead_para {
> > +    /*
> > +     * Byte Length of valid IV data.
> > +     *
> > +     * For GCM mode, this is either 12 (for 96-bit IVs) or 16, in whic=
h
> > +     *   case iv points to J0.
> > +     * For CCM mode, this is the length of the nonce, which can be in =
the
> > +     *   range 7 to 13 inclusive.
> > +     */
> > +    le32 iv_len;
> > +    /* length of additional auth data */
> > +    le32 aad_len;
> > +    /* length of source data */
> > +    le32 src_data_len;
> > +    /* length of dst data, this should be at least src_data_len + tag_=
len */
> > +    le32 dst_data_len;
> > +    /* Authentication tag length */
> > +    le32 tag_len;
> > +    le32 reserved;
> > +};
> > +
> > +struct virtio_crypto_aead_data_req {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_aead_para para;
> > +    /*
> > +     * Initialization Vector data.
> > +     *
> > +     * For GCM mode, this is either the IV (if the length is 96 bits) =
or J0
> > +     *   (for other sizes), where J0 is as defined by NIST SP800-38D.
> > +     *   Regardless of the IV length, a full 16 bytes needs to be allo=
cated.
> > +     * For CCM mode, the first byte is reserved, and the nonce should =
be
> > +     *   written starting at &iv[1] (to allow space for the implementa=
tion
> > +     *   to write in the flags in the first byte).  Note that a full 1=
6 bytes
> > +     *   should be allocated, even though the iv_len field will have
> > +     *   a value less than this.
> > +     *
> > +     * The IV will be updated after every partial cryptographic operat=
ion.
> > +     */
> > +    u8 iv[iv_len];
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +    /* Additional authenticated data if exists  */
> > +    u8 aad[aad_len];
> > +
> > +    /* Device-writable part */
> > +    /* Pointer to output data */
> > +    u8 dst_data[dst_data_len];
> > +
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +Each data request uses virtio_crypto_aead_data_req structure to store
> information
> > +used to run the AEAD operations.
> > +
> > +The information includes the hash parameters stored by \field{para}, o=
utput
> data and input data.
> > +In the first virtio_crypto_aead_para structure, \field{iv_len} specifi=
es the
> length of the initialization vector. \field{tag_len} specifies the length=
 of the
> authentication tag;
> > +\field{aad_len} specifies the length of additional authentication data=
,
> \field{src_data_len} specifies the
> > +length of the source data; \field{dst_data_len} specifies the length o=
f the
> destination data, which is at least \field{src_data_len} + \field{tag_len=
}.
> > +
> > +The output data here includes the IV/Counter data, source data and
> additional authenticated data if exists.
> > +The input data includes both destination data used to save the results=
 of the
> AEAD operations.
> > +\field{inhdr} stores status of executing the AEAD operations.
> > +
> > +The stateless mode request of AEAD service is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_crypto_aead_para_stateless {
> > +    struct {
> > +        /* See VIRTIO_CRYPTO_AEAD_* above */
> > +        le32 algo;
> > +        /* length of key */
> > +        le32 key_len;
> > +        /* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
> > +        le32 op;
> > +    } sess_para;
> > +
> > +    /* Byte Length of valid IV data. */
> > +    le32 iv_len;
> > +    /* Authentication tag length */
> > +    le32 tag_len;
> > +    /* length of additional auth data */
> > +    le32 aad_len;
> > +    /* length of source data */
> > +    le32 src_data_len;
> > +    /* length of dst data, this should be at least src_data_len + tag_=
len */
> > +    le32 dst_data_len;
> > +};
> > +
> > +struct virtio_crypto_aead_data_req_stateless {
> > +    /* Device-readable part */
> > +    struct virtio_crypto_aead_para_stateless para;
> > +    /* The cipher key */
> > +    u8 key[key_len];
> > +    /* Initialization Vector data. */
> > +    u8 iv[iv_len];
> > +    /* Source data */
> > +    u8 src_data[src_data_len];
> > +    /* Additional authenticated data if exists  */
> > +    u8 aad[aad_len];
> > +
> > +    /* Device-writable part */
> > +    /* Pointer to output data */
> > +    u8 dst_data[dst_data_len];
> > +
> > +    struct virtio_crypto_inhdr inhdr;
> > +};
> > +\end{lstlisting}
> > +
> > +\drivernormative{\paragraph}{AEAD Service Operation}{Device Types /
> Crypto Device / Device Operation / AEAD Service Operation}
> > +
> > +\begin{itemize*}
> > +\item If the driver uses the session mode, then the driver MUST set th=
e
> \field{session_id} in struct virtio_crypto_op_header
> > +      to a valid value which assigned by the device when a session is
> created.
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap cryp=
to
> requests. Otherwise, the driver MUST use the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE feature bit is
> negotiated, 1) if the driver use the stateless mode, then the driver MUST=
 set
> \field{flag} field in struct virtio_crypto_op_header
> > +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set fields in
> struct virtio_crypto_aead_para_statelession.sess_para, 2) if the driver s=
till
> uses the session mode, then the driver MUST set \field{flag} field in str=
uct
> virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
> > +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_he=
ader
> to VIRTIO_CRYPTO_AEAD_ENCRYPT or VIRTIO_CRYPTO_AEAD_DECRYPT.
> > +\end{itemize*}
> > +
> > +\devicenormative{\paragraph}{AEAD Service Operation}{Device Types /
> Crypto Device / Device Operation / AEAD Service Operation}
> > +
> > +\begin{itemize*}
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the device MUST parse the struct virtio_crypto_op_data_req_mux for crypto
> requests. Otherwise, the device MUST parse the struct
> virtio_crypto_op_data_req.
> > +\item If the VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE feature bit is
> negotiated, the device MUST parse the virtio_crypto_aead_data_req based o=
n
> the \field{opcode} in general header.
> > +\item The device MUST copy the result of cryptographic operation to th=
e
> dst_data[].
> > +\item The device MUST copy the authentication tag to the dst_data[] of=
fset
> the cipher result.
> > +\item The device MUST set the \field{status} field in struct
> virtio_crypto_inhdr to one of the values of enum VIRITO_CRYPTO_STATUS.
>=20
> VIRTIO typo
>=20
Fixed.

Thanks,
-Gonglei

> > +\item When the \field{opcode} is VIRTIO_CRYPTO_AEAD_DECRYPT, the
> device MUST verify and return the verification result to the driver, and =
if the
> verification result is incorrect, VIRTIO_CRYPTO_BADMSG (bad message) MUST
> be returned to the driver.
> > +\end{itemize*}
> > \ No newline at end of file
> > --
> > 1.7.12.4
> >
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
