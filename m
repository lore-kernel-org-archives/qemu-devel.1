Received: from eggs.gnu.org ([2001:4830:134:3::10]:38384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1YHH-0001Pq-Vg
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1YHD-0005nO-Vs
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:07:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d1YHD-0005mF-MM
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:07:07 -0400
Date: Fri, 21 Apr 2017 14:07:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170421130700.GA5531@stefanha-x1.localdomain>
References: <1492074674-124192-1-git-send-email-arei.gonglei@huawei.com>
	<1492074674-124192-2-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <1492074674-124192-2-git-send-email-arei.gonglei@huawei.com>
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
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, zhbzg@huawei.com, eety.chen@huawei.com, amy.zhanghuimin@huawei.com, maoningning@huawei.com


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 05:11:13PM +0800, Gonglei wrote:
> +The request of dataq, mixing both session and stateless mode is as follo=
ws:

It sounds more natural when "request" is plural:

"Dataq requests for both session and stateless modes are as follows:"

> +
> +\begin{lstlisting}
> +struct virtio_crypto_op_data_req_mux {
> +    struct virtio_crypto_op_header header;
> +
> +    union {
> +        struct virtio_crypto_sym_data_req   sym_req;
> +        struct virtio_crypto_hash_data_req  hash_req;
> +        struct virtio_crypto_mac_data_req   mac_req;
> +        struct virtio_crypto_aead_data_req  aead_req;
> +        struct virtio_crypto_sym_data_req_stateless   sym_stateless_req;
> +        struct virtio_crypto_hash_data_req_stateless  hash_stateless_req;
> +        struct virtio_crypto_mac_data_req_stateless   mac_stateless_req;
> +        struct virtio_crypto_aead_data_req_stateless  aead_stateless_req;
> +    } u;
> +};
> +\end{lstlisting}
> +
> +The header is the general header and the union is of the algorithm-speci=
fic type,
> +which is set by the driver. All properties in the union are shown as fol=
lows.
> +
> +There is a unified input header structure for all crypto services.
> +
> +The structure is defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_inhdr {
> +    u8 status;
> +};
> +\end{lstlisting}
> +
> +\subsubsection{HASH Service Operation}\label{sec:Device Types / Crypto D=
evice / Device Operation / HASH Service Operation}
> +
> +The session mode request of HASH service:

Plural "request":

"Session mode HASH service requests are defined as follows:"

> +
> +\begin{lstlisting}
> +struct virtio_crypto_hash_para {
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* hash result length */
> +    le32 hash_result_len;
> +};
> +
> +struct virtio_crypto_hash_data_req {
> +    /* Device-readable part */
> +    struct virtio_crypto_hash_para para;
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +Each data request uses virtio_crypto_hash_data_req structure to store in=
formation
> +used to run the HASH operations.=20
> +
> +The information includes the hash parameters stored by \field{para}, out=
put data and input data.

"stored in $container" vs "stored by $actor_or_service_or_action".  For
example:

"stored in register EAX" <-- container
"stored in /etc/passwd" <-- container
"stored by the worker thread" <-- actor
"stored by calling api_write()" <-- action
"stored by ext4" <-- service

Since \field{para} is a container it needs to be "stored in
\field{para}".

> +The output data here includes the source data and the input data include=
s the hash result data used to save the results of the HASH operations.
> +\field{inhdr} stores status of executing the HASH operations.

Missing article: "stores the status"

> +
> +The stateless mode request of HASH service is as follows:

Plural "requests":

"Stateless mode HASH service requests are as follows:"

(The same applies to more instances below.)

> +
> +\begin{lstlisting}
> +struct virtio_crypto_hash_para_statelesss {
> +    struct {
> +        /* See VIRTIO_CRYPTO_HASH_* above */
> +        le32 algo;
> +    } sess_para;
> +
> +    /* length of source data */
> +    le32 src_data_len;
> +    /* hash result length */
> +    le32 hash_result_len;
> +    le32 reserved;
> +};
> +struct virtio_crypto_hash_data_req_stateless {
> +    /* Device-readable part */
> +    struct virtio_crypto_hash_para_stateless para;
> +    /* Source data */
> +    u8 src_data[src_data_len];
> +
> +    /* Device-writable part */
> +    /* Hash result data */
> +    u8 hash_result[hash_result_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
> +\end{lstlisting}
> +
> +\drivernormative{\paragraph}{HASH Service Operation}{Device Types / Cryp=
to Device / Device Operation / HASH Service Operation}
> +
> +\begin{itemize*}
> +\item If the driver uses the session mode, then the driver MUST set the =
\field{session_id} in struct virtio_crypto_op_header
> +      to a valid value which assigned by the device when a session is cr=
eated.

Please see my previous email for a change to "a valid value which
assigned by the device when a session is created".

> +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated, t=
he driver MUST use the struct virtio_crypto_op_data_req_mux to wrap crypto =
requests. Otherwise, the driver MUST use the struct virtio_crypto_op_data_r=
eq.

The article is omitted when referring to a specific named object:
"use struct virtio_crypto_op_data_req_mux" and "use struct virtio_crypto_op=
_data_req"

> +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiat=
ed, 1) if the driver use the stateless mode, then the driver MUST set \fiel=
d{flag} field in struct virtio_crypto_op_header

"he/she/it uses" so it should be "if the driver uses the stateless
mode".

"set X field" is missing a definite article.  Either add "the" ("set the
X field") or drop "field" so that X isn't a member of a group ("set X"):
"set \field{flag} in struct virtio_crypto_op_header"

https://owl.english.purdue.edu/owl/resource/540/01/

> +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set fields in struct=
 virtio_crypto_hash_para_statelession.sess_para, 2) if the driver still use=
s the session mode, then the driver MUST set \field{flag} field in struct v=
irtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.

I don't understand the meaning of "still" here.  Maybe it was meant to
be "instead"?  It's simplest to drop it:
s/driver still uses/driver uses/

s/MUST set \field{flag} field/MUST set \field{flag}/

> +\item The driver MUST set \field{opcode} in struct virtio_crypto_op_head=
er to VIRTIO_CRYPTO_HASH.
> +\end{itemize*}
> +
> +\devicenormative{\paragraph}{HASH Service Operation}{Device Types / Cryp=
to Device / Device Operation / HASH Service Operation}
> +
> +\begin{itemize*}
> +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated, t=
he device MUST parse the struct virtio_crypto_op_data_req_mux for crypto re=
quests. Otherwise, the device MUST parse the struct virtio_crypto_op_data_r=
eq.
> +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is negotiat=
ed, the device MUST parse \field{flag} field in struct virtio_crypto_op_hea=
der in order to decide which mode the driver uses.
> +\item The device MUST copy the results of HASH operations to the hash_re=
sult[] if HASH operations success.
> +\item The device MUST set \field{status} in struct virtio_crypto_inhdr t=
o one of the values of enum VIRITO_CRYPTO_STATUS.
> +\end{itemize*}

More instances of the same grammar issues mentioned above.  This is a
good point to stop review for now and wait for the next revision that
fixes them throughout the document.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY+gP0AAoJEJykq7OBq3PIhL4H/iwJ/urzIBv4HalvMJmtRt+e
WhRGasMQ7A2Qkt8dh8ylwjOh9OLaHZHNpcLGqpo8pTh+RaCjUMDiXKr27bl3xCCo
t880d3o+t6BdlUPQdmZUsmtApWobrr0KFMSDcnByQsprkliQ04HyGkXfyxKjPSSe
botyZdkeXAfzuDDbXs12DOWaNFdZiZOwEOMDb0P3cJIkdHyZCabPI5SrmHno1nap
yMOJXn+AnZL8/fbj7cC/DiHP4TV4KXEltPrpuAsz4p706UG3oHrAKrpDYf+RE43c
hBgPhh7U6gSpx94yFWCVTld5m4v4XdsEkkP7wPDm72p9bLc0hrQrvBsA6JB2fHs=
=XGFs
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
