Received: from eggs.gnu.org ([2001:4830:134:3::10]:33719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6U6J-0004GT-V9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6U6F-0007Yo-6n
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:40:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6U6E-0007T2-9L
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:40:11 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 5 May 2017 03:39:45 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA26484F@DGGEMA505-MBX.china.huawei.com>
References: <1492842231-223720-1-git-send-email-arei.gonglei@huawei.com>
	<1492842231-223720-2-git-send-email-arei.gonglei@huawei.com>
	<38d13582-47f4-2a03-efef-064063c8852f@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA263F82@DGGEMA505-MBX.china.huawei.com>
	<17594b34-62c0-bc4e-2fda-fc54837e0732@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA264026@DGGEMA505-MBX.china.huawei.com>
	<40d5eb58-0f6a-5da4-83d2-656f0abfcf0f@linux.vnet.ibm.com>
In-Reply-To: <40d5eb58-0f6a-5da4-83d2-656f0abfcf0f@linux.vnet.ibm.com>
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
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "lixiao (H)" <lixiao91@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Zhbzg <zhbzg@huawei.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Linqiangmin <linqiangmin@huawei.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>

>=20
>=20
> On 05/04/2017 04:13 PM, Gonglei (Arei) wrote:
> >>
> >>
> >> On 05/04/2017 03:33 PM, Gonglei (Arei) wrote:
> >>>>> +\begin{description}
> >>>>> +\item[VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE] Requires
> >>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>>>> +\item[VIRTIO_CRYPTO_F_HASH_STATELESS_MODE] Requires
> >>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>>>> +\item[VIRTIO_CRYPTO_F_MAC_STATELESS_MODE] Requires
> >>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>>>> +\item[VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE] Requires
> >>>> VIRTIO_CRYPTO_F_STATELESS_MODE.
> >>>>> +\end{description}
> >>>>
> >>>> I find feature bit 0 redundant and bit confusing. We had a discussio=
n
> >>>> in v15 and v16.
> >>>>
> >>>> Could you answer:
> >>>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03214.html
> >>>> (Message-ID:
> >> <1fbe30cc-87ec-32bc-4c57-85f9b03b3034@linux.vnet.ibm.com>)
> >>>>
> >>>>
> >>> Please see my reply:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03186.html
> >>>
> >>> The main reason is we should keep compatibility to pre-existing drive=
r and
> >>> support some function that different services have different modes.
> >>> We have only one unique crypto request named structure
> >> virtio_crypto_op_data_req_mux.
> >>> Please continue to see the sepc, you'll find the truth.
> >>>
> >>
> >> Sorry, I still do not understand why can't we drop
> >> VIRTIO_CRYPTO_F_STATELESS_MODE
> >> and just keep the four service specific modes.
> >>
> >> Can you point me to the (published) code where
> >> VIRTIO_CRYPTO_F_STATELESS_MODE is
> >> used (that's what I'm missing -- preferably state the repository, the =
commit
> >> a file and a line using VIRTIO_CRYPTO_F_STATELESS_MODE)?
> >>
> > No no no, there isn't existing code use VIRTIO_CRYPTO_F_STATELESS_MODE
> yet,
> > It's just for future use.
> >
>=20
> Thanks, that's a crucial piece of information. In the thread I referenced
> this was not cleared (at least for me). It would be really nice to have
> some working code before doing the spec, because I find it very easy to m=
iss
> a detail which renders the whole thing useless if one works solely on
> theoretical level and does not try to create at least a working prototype=
.
>=20
I see.

> > Please the blow description:
> > """
> > \drivernormative{\paragraph}{HASH Service Operation}{Device Types / Cry=
pto
> Device / Device Operation / HASH Service Operation}
> >
> > \begin{itemize*}
> > \item If the driver uses the session mode, then the driver MUST set
> \field{session_id} in struct virtio_crypto_op_header
> >       to a valid value assigned by the device when the session was crea=
ted.
> > \item If the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit is negotiated,
> the driver MUST use struct virtio_crypto_op_data_req_mux to wrap crypto
> requests. Otherwise, the driver MUST use struct virtio_crypto_op_data_req=
.
> > \item If the VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is
> negotiated, 1) if the driver uses the stateless mode, then the driver MUS=
T set
> the \field{flag} field in struct virtio_crypto_op_header
> >       to VIRTIO_CRYPTO_FLAG_STATELESS_MODE and MUST set the fields
> in struct virtio_crypto_hash_para_statelession.sess_para, 2) if the drive=
r uses
> the session mode, then the driver MUST set the \field{flag} field in stru=
ct
> virtio_crypto_op_header to VIRTIO_CRYPTO_FLAG_STATE_MODE.
> > \item The driver MUST set \field{opcode} in struct virtio_crypto_op_hea=
der to
> VIRTIO_CRYPTO_HASH.
> > \end{itemize*}
> > """
> >
> > If we drop the VIRTIO_CRYPTO_F_STATELESS_MODE feature bit, and the
> > VIRTIO_CRYPTO_F_HASH_STATELESS_MODE feature bit is not negotiated,
> > then the driver doesn't to know use which structure to store the crypto
> request:
> > is struct virtio_crypto_op_data_req_mux ? or struct
> virtio_crypto_op_data_req.
>=20
> Thanks for the detailed explanation.
>=20
> Let's clarify some things first:
> 1) struct virtio_crypto_op_data_req_mux IS NOT a C language struct but
> a somewhat informal desciption using C-like syntax. If you don't follow
> try to reason about the size of struct virtio_crypto_op_data_req_mux.
> For instance look at:
> +struct virtio_crypto_cipher_data_req_stateless {
> +    /* Device-readable part */
> +    struct virtio_crypto_cipher_para_stateless para;
> +    /* The cipher key */
> +    u8 cipher_key[keylen];
> +
> +    /* Initialization Vector or Counter data. */
> +    u8 iv[iv_len];
> +    /* Source data */
> +    u8 src_data[src_data_len];           <=3D=3D
>=20
> The  isrc_data_len is not a compile time constant!!
>=20
> +
> +    /* Device-writable part */
> +    /* Destination data */
> +    u8 dst_data[dst_data_len];
> +    struct virtio_crypto_inhdr inhdr;
> +};
>=20
> Using something like BNF to describe the requests would be
> less ambiguous but likely more difficult to read and reason about
> for most of us (and also inconsistent with the rest of the spec).
>=20
I used to use src_data_gpa/dst_data_gpa to express the data,
But you thought it's not clear, so I changed to use u8[len] like
virtio-scsi device in the virtio spec as your suggested.

struct virtio_scsi_req_cmd {
	// Device-readable part
	u8 lun[8];
	le64 id;
	u8 task_attr;
	u8 prio;
	u8 crn;
	u8 cdb[cdb_size];
	// The next two fields are only present if VIRTIO_SCSI_F_T10_PI
	// is negotiated.
	le32 pi_bytesout;
	le32 pi_bytesin;
	u8 pi_out[pi_bytesout];
	u8 dataout[];
	// Device-writable part
	le32 sense_len;
	le32 residual;
	le16 status_qualifier;
	u8 status;
	u8 response;
	u8 sense[sense_size];
	// The next two fields are only present if VIRTIO_SCSI_F_T10_PI
	// is negotiated
	u8 pi_in[pi_bytesin];
	u8 datain[];
};

> 2) Each struct virtio_crypto_op_data_req is also a struct
> virtio_crypto_op_data_req_mux
> in a sense of 1).
>=20
> 3) The header struct virtio_crypto_op_header is a common prefix for
> struct virtio_crypto_op_data_req and a struct
> virtio_crypto_op_data_req_mux.
>=20
Yes.

>=20
> >
> > We assume the driver uses struct virtio_crypto_op_data_req, what about =
the
> device?
> > The device doesn't know how to parse the request in the
> virtio_crypto_handle_request()
> > of virito-crypto.c in Qemu.
> >
> > static int
> > virtio_crypto_handle_request(VirtIOCryptoReq *request)
> > {
> >     VirtIOCrypto *vcrypto =3D request->vcrypto;
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(vcrypto);
> >     VirtQueueElement *elem =3D &request->elem;
> >     int queue_index =3D
> virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
> >     struct virtio_crypto_op_data_req req; ???
> >
> >     ///or struct virtio_crypto_op_data_req_mux req; ???
> >
>=20
> Because of 3) and because the service associated with the request can be
> inferred
> form virtio_crypto_op_header one can answer the question you as, and deci=
de
> if what comes after the header is a stateless or a session variant based
> on virtio_crypto_op_header.flag -- maybe it does not even need opcode
> to do that.
>=20
Yes, you are right. We can get the common header:

static int
virtio_crypto_handle_request(VirtIOCryptoReq *request)
{
...
struct virtio_crypto_op_header header;

iov_to_buf(out_iov, out_num, 0, &header, sizeof(header));

...

Then we check the header.flag:=20

If (header.flag =3D=3D VIRTIO_CRYPTO_FLAG_STATELESS_MOD) {
  //Use struct virtio_crypto_op_data_req_mux req;
} else if (header.flag =3D=3D VIRTIO_CRYPTO_FLAG_SESSION_MOD) {
  //Use struct virtio_crypto_op_data_req_mux req;
} else {
  //Use struct virtio_crypto_op_data_req req;
}

But for existing code we don't use the header.flag to check the request,=20
Will it break the pre-existing code? Because we don't assume header.flag is
zero before.


> Thus (IMHO) dropping VIRTIO_CRYPTO_F_STATELESS_MODE is possible.
>=20
> Or is there a flaw in my reasoning?
>=20

Thanks,
-Gonglei
