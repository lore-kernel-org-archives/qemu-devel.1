Received: from eggs.gnu.org ([2001:4830:134:3::10]:41636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dATTw-0006c6-5K
	for qemu-devel@nongnu.org; Mon, 15 May 2017 23:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dATTt-0002fa-1V
	for qemu-devel@nongnu.org; Mon, 15 May 2017 23:49:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dATTr-0002YU-Mt
	for qemu-devel@nongnu.org; Mon, 15 May 2017 23:49:04 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 16 May 2017 03:48:19 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA29A11A@DGGEMA505-MBS.china.huawei.com>
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<1e56f82e-6afb-af30-acb9-6f66373c7bc2@linux.vnet.ibm.com>
In-Reply-To: <1e56f82e-6afb-af30-acb9-6f66373c7bc2@linux.vnet.ibm.com>
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

Sorry for delay because I'm busy on inner production project recently.

>=20
>=20
> START HERE
>=20
> > +The device can set the operation status as follows: VIRTIO_CRYPTO_OK:
> success;
> > +VIRTIO_CRYPTO_ERR: failure or device error; VIRTIO_CRYPTO_NOTSUPP:
> not supported;
> > +VIRTIO_CRYPTO_INVSESS: invalid session ID when executing crypto
> operations.
>=20
> You describe everything but BADMSG. Could you be a bit more specific
> about the differences between _ERR _BADMSG and _NOTSUPP? Is for instance
> trying
> to do something with a not-advertised service or algo a _NOTSUPP or a
> _BADMSG or just a generic _ERR? Same qestion goes for different sorts of
> out of resources.
>=20
Sure. Will do.

> > +
> > +\begin{lstlisting}
> > +enum VIRTIO_CRYPTO_STATUS {
> > +    VIRTIO_CRYPTO_OK =3D 0,
> > +    VIRTIO_CRYPTO_ERR =3D 1,
> > +    VIRTIO_CRYPTO_BADMSG =3D 2,
> > +    VIRTIO_CRYPTO_NOTSUPP =3D 3,
> > +    VIRTIO_CRYPTO_INVSESS =3D 4,
> > +    VIRTIO_CRYPTO_MAX
> > +};
> > +\end{lstlisting}
> > +
>=20
> There are no more mentions of the values in the spec, so the description
> above should be real good.
>=20
Agree.

> > +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Devi=
ce /
> Device Operation / Control Virtqueue}
> > +
> > +The driver uses the control virtqueue to send control commands to the
> > +device, such as session operations (See \ref{sec:Device Types / Crypto
> Device / Device Operation / Control Virtqueue / Session operation}).
> > +
> > +Controlq requests are as follows:
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
> > +struct virtio_crypto_op_ctrl_req is the only allowed control request.
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
> > +a number of buffers.
>=20
> 8<
> > The data within a session handle includes:
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
> >8
>=20
> This part is slightly confusing for me. I guess you are trying to describ=
e
> what data can live in the session context (considering all the different
> applications). I think we do not have to describe that here, because we h=
ave
> to describe the individual session operations, and there we must describe
> the precise impact of these operations (and their parameters).
>=20
Make sense to me.

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
> > +HASH session requests are as follows:
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
> > +MAC session requests are as follows:
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
> > +algorithms (chaining CIPHER and HASH/MAC).
> > +
> > +CIPHER session requests are as follows:
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
> > +Algorithm chaining requests are as follows:
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
> > +Symmetric algorithm requests are as follows:
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
> > +The driver can set the \field{op_type} field in struct
> virtio_crypto_sym_create_session_req as follows:
> VIRTIO_CRYPTO_SYM_OP_NONE: no operation;
> > +VIRTIO_CRYPTO_SYM_OP_CIPHER: Cipher only operation on the data;
> VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING: Chain any cipher with any
> hash or mac operation.
> > +
> > +\subparagraph{Session operation: AEAD session}\label{sec:Device Types =
/
> Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:=
 AEAD
> session}
> > +
> > +AEAD session requests are as follows:
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
> > +\item The driver MUST set the \field{opcode} field based on service ty=
pe:
> CIPHER, HASH, MAC, or AEAD.
>=20
> > +\item The driver MUST set the \field{queue_id} field to show used data=
q.
>=20
> Used for what? Is the driver obligued to use that dataq for the op reqs
> associated
> with the given session. If yes where is the normative statement?
>=20
Yes, I missed.


> > +\end{itemize*}
> > +
> > +\devicenormative{\subparagraph}{Session operation: create session}{Dev=
ice
> Types / Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:
> create session}
> > +
> > +\begin{itemize*}
> > +\item The device MUST set the \field{session_id} field to a unique ses=
sion
> identifier when the device finishes processing session creation.
>=20
> I guess only if successfull (that is status =3D=3D VIRTIO_CRYPTO_OK).
>=20
Sure. Let me add the condition.

> > +\item The device MUST set the \field{status} field to one of the value=
s of
> enum VIRTIO_CRYPTO_STATUS.
>=20
> Maybe put this one first. The formulation could be more fortunate in
> a sense that it's required to set the right status (_OK if successs,
> _NOTSUPP if ...).
>=20
> What shall happen if the operation fails, e.g. becasue of out of resource=
s?
>=20
That means the driver can't create session, and the following crypto
operation are forbidden.

> Is there some sort of limit for the amount of live sessions (related to
> the previous question)? Obviously the device needs storage for the
> session data. Can the guest DOS attack the host by creating an absurd num=
ber
> of sessions?
>=20
Good question. It's true that the guest can trigger DoS attack.
What's your opinion about the limit in the spec? Add a new feature?


> > +\end{itemize*}
> > +
> > +\drivernormative{\subparagraph}{Session operation: destroy
> session}{Device Types / Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:
> destroy session}
> > +
> > +\begin{itemize*}
> > +\item The driver MUST set the \field{opcode} field based on service ty=
pe:
> CIPHER, HASH, MAC, or AEAD.
> > +\item The driver MUST set the \field{session_id} to a valid value assi=
gned by
> the device when the session was created.
> > +\end{itemize*}
> > +
> > +\devicenormative{\subparagraph}{Session operation: destroy
> session}{Device Types / Crypto Device / Device
> > +Operation / Control Virtqueue / Session operation / Session operation:
> destroy session}
> > +
> > +\begin{itemize*}
> > +\item The device MUST set the \field{status} field to one of the value=
s of
> enum VIRTIO_CRYPTO_STATUS.
>=20
> Same as above.
>=20
OK.

> > +\end{itemize*}
> > +
> > +\subsubsection{Data Virtqueue}\label{sec:Device Types / Crypto Device =
/
> Device Operation / Data Virtqueue}
> > +
> > +The driver uses the data virtqueue to transmit crypto operation reques=
ts to
> the device,
> > +and completes the crypto operations.
> > +
> > +Session mode dataq requests are as follows:
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
> > +Dataq requests for both session and stateless modes are as follows:
>=20
> This ain't very nice, I mean the 'both session and stateless modes' toget=
her

So what's your idea?

> with the above 'session mode dataq requests are'. In the meanwhile I know
> what
> you mean: if the SESSION_MODE feature bit was negotiated.
>=20
Yes, that's what I want. If the MUX_MODE feature bit is negotiated, the
driver MUST use struct virtio_crypto_op_data_req_mux for requests.


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
> > +Session mode HASH service requests are as follows:
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
> > +The information includes the hash parameters stored in \field{para}, o=
utput
> data and input data.
> > +The output data here includes the source data and the input data inclu=
des
> the hash result data used to save the results of the HASH operations.
> > +\field{inhdr} stores the status of executing the HASH operations.
> > +
> > +Stateless mode HASH service requests are as follows:
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
> > +\item If the driver uses the session mode, then the driver MUST set
> \field{session_id} in struct virtio_crypto_op_header
> > +      to a valid value assigned by the device when the session was
> created.
> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the driver MUST use struct virtio_crypto_op_data_req_mux to wrap crypto
> requests. Otherwise, the driver MUST use struct virtio_crypto_op_data_req=
.
> > +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is
> negotiated, 1) if the driver uses the stateless mode, then the driver MUS=
T set
> the \field{flag} field in struct virtio_crypto_op_header
> > +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set the fields
> in struct virtio_crypto_hash_para_statelession.sess_para, 2) if the drive=
r uses
> the session mode, then the driver MUST set the \field{flag} field in stru=
ct
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
> > +\item The device MUST copy the results of HASH operations in the
> hash_result[] if HASH operations success.
> > +\item The device MUST set \field{status} in struct virtio_crypto_inhdr=
 to one
> of the values of enum VIRTIO_CRYPTO_STATUS.
> > +\end{itemize*}
> > +
>=20
> OK, I have read this to the end and I don't think there is anything which=
 requires
> a comment at this stage. I would like to concentrate on your QEMU patches
> first,
> and I think we have enough questions/issues already.
>=20

Great thanks for your comments. Pls go ahead. :)

Thanks,
-Gonglei
