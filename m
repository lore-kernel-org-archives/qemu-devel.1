Received: from eggs.gnu.org ([2001:4830:134:3::10]:49449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1YnG-0001fb-Rx
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1YnC-00009b-A5
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:40:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3453
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1YnB-0008WM-DW
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:40:10 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 13:39:32 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238CAC@DGGEMA505-MBS.china.huawei.com>
References: <1492074674-124192-1-git-send-email-arei.gonglei@huawei.com>
	<1492074674-124192-2-git-send-email-arei.gonglei@huawei.com>
	<20170421130700.GA5531@stefanha-x1.localdomain>
In-Reply-To: <20170421130700.GA5531@stefanha-x1.localdomain>
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


> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Friday, April 21, 2017 9:07 PM
>
> Subject: Re: [virtio-dev] [PATCH v17 1/2] virtio-crypto: Add virtio crypt=
o device
> specification
>=20
> On Thu, Apr 13, 2017 at 05:11:13PM +0800, Gonglei wrote:
> > +The request of dataq, mixing both session and stateless mode is as fol=
lows:
>=20
> It sounds more natural when "request" is plural:
>=20
> "Dataq requests for both session and stateless modes are as follows:"
>=20
OK.

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
>=20
> Plural "request":
>=20
> "Session mode HASH service requests are defined as follows:"
>=20
Fixed.

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
>=20
> "stored in $container" vs "stored by $actor_or_service_or_action".  For
> example:
>=20
> "stored in register EAX" <-- container
> "stored in /etc/passwd" <-- container
> "stored by the worker thread" <-- actor
> "stored by calling api_write()" <-- action
> "stored by ext4" <-- service
>=20
> Since \field{para} is a container it needs to be "stored in
> \field{para}".
>=20
Great thanks :)
All fixed.

> > +The output data here includes the source data and the input data inclu=
des
> the hash result data used to save the results of the HASH operations.
> > +\field{inhdr} stores status of executing the HASH operations.
>=20
> Missing article: "stores the status"
>=20
All fixed.

> > +
> > +The stateless mode request of HASH service is as follows:
>=20
> Plural "requests":
>=20
> "Stateless mode HASH service requests are as follows:"
>=20
> (The same applies to more instances below.)
>=20
All fixed.

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
>=20
> Please see my previous email for a change to "a valid value which
> assigned by the device when a session is created".
>=20
Sure, all fixed.

> > +\item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the driver MUST use the struct virtio_crypto_op_data_req_mux to wrap cryp=
to
> requests. Otherwise, the driver MUST use the struct
> virtio_crypto_op_data_req.
>=20
> The article is omitted when referring to a specific named object:
> "use struct virtio_crypto_op_data_req_mux" and "use struct
> virtio_crypto_op_data_req"
>=20
OK, all fixed.

> > +\item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is
> negotiated, 1) if the driver use the stateless mode, then the driver MUST=
 set
> \field{flag} field in struct virtio_crypto_op_header
>=20
> "he/she/it uses" so it should be "if the driver uses the stateless
> mode".
>=20
Yes, all fixed.

> "set X field" is missing a definite article.  Either add "the" ("set the
> X field") or drop "field" so that X isn't a member of a group ("set X"):
> "set \field{flag} in struct virtio_crypto_op_header"
>=20
> https://owl.english.purdue.edu/owl/resource/540/01/
>=20
OK, I get it. All fixed.

> > +      to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set fields in
> struct virtio_crypto_hash_para_statelession.sess_para, 2) if the driver s=
till
> uses the session mode, then the driver MUST set \field{flag} field in str=
uct
> virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
>=20
> I don't understand the meaning of "still" here.  Maybe it was meant to
> be "instead"?  It's simplest to drop it:
> s/driver still uses/driver uses/
>=20
OK. All fixed.

> s/MUST set \field{flag} field/MUST set \field{flag}/
>=20
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
> > +\end{itemize*}
>=20
> More instances of the same grammar issues mentioned above.  This is a
> good point to stop review for now and wait for the next revision that
> fixes them throughout the document.

Thanks for your patience Stefan. I have finished the fixes as your suggesti=
ons
Throughout the document.

Thanks!
-Gonglei
