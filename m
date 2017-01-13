Received: from eggs.gnu.org ([2001:4830:134:3::10]:50147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRs1i-0002g4-T0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRs1f-0001ET-NK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:55:38 -0500
Received: from [45.249.212.188] (port=2447 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cRs1c-00016g-Pm
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:55:35 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 13 Jan 2017 02:54:29 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA18F9A0@DGGEMA505-MBX.china.huawei.com>
References: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA174989@DGGEMA505-MBX.china.huawei.com>
	<63cd3678-4044-365d-d396-1040f5755e2c@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA18DE85@DGGEMA505-MBX.china.huawei.com>
	<20170112214414-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170112214414-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v15 0/2] virtio-crypto:
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>


>=20
> On Thu, Jan 12, 2017 at 12:26:24PM +0000, Gonglei (Arei) wrote:
> > Hi,
> >
> >
> > >
> > > On 01/04/2017 11:10 AM, Gonglei (Arei) wrote:
> > > > Hi all,
> > > >
> > > > I attach the diff files between v14 and v15 for better review.
> > > >
> > > Hi,
> > >
> > > only had a quick look. Will try to come back to this later.
> > >
> > That's cool.
> >
> > > > diff --git a/virtio-crypto.tex b/virtio-crypto.tex
> > > > index 9f7faf0..884ee95 100644
> > > > --- a/virtio-crypto.tex
> > > > +++ b/virtio-crypto.tex
> > > > @@ -2,8 +2,8 @@
> > > >
> > > >  The virtio crypto device is a virtual cryptography device as well =
as a kind
> of
> > > >  virtual hardware accelerator for virtual machines. The encryption =
and
> > > > -decryption requests are placed in the data queue and are ultimatel=
y
> handled
> > > by the
> > > > -backend crypto accelerators. The second queue is the control queue=
 used
> to
> > > create
> > > > +decryption requests are placed in any of the data active queues an=
d are
> > > ultimately handled by the
> > > s/data active/active data/
> > > > +backend crypto accelerators. The second kind of queue is the contr=
ol
> queue
> > > used to create
> > > >  or destroy sessions for symmetric algorithms and will control some
> > > advanced
> > > >  features in the future. The virtio crypto device provides the foll=
owing
> crypto
> > > >  services: CIPHER, MAC, HASH, and AEAD.
> > >
> > > [..]
> > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe below diff shows t=
he changes of add non-session
> mode
> > > support:
> > > >
> > > > diff --git a/virtio-crypto.tex b/virtio-crypto.tex
> > > > index 884ee95..44819f9 100644
> > > > --- a/virtio-crypto.tex
> > > > +++ b/virtio-crypto.tex
> > > > @@ -26,7 +26,10 @@ N is set by \field{max_dataqueues}.
> > > >
> > > >  \subsection{Feature bits}\label{sec:Device Types / Crypto Device /
> Feature
> > > bits}
> > > >
> > > > -None currently defined.
> > > > +VIRTIO_CRYPTO_F_CIPHER_SESSION_MODE (1) Session mode is
> available
> > > for CIPHER service.
> > > > +VIRTIO_CRYPTO_F_HASH_SESSION_MODE (2) Session mode is available
> for
> > > HASH service.
> > > > +VIRTIO_CRYPTO_F_MAC_SESSION_MODE (3) Session mode is available
> for
> > > MAC service.
> > > > +VIRTIO_CRYPTO_F_AEAD_SESSION_MODE (4) Session mode is available
> for
> > > AEAD service.
> > > >
> > > >  \subsection{Device configuration layout}\label{sec:Device Types /
> Crypto
> > > Device / Device configuration layout}
> > > >
> > > > @@ -208,6 +211,9 @@ Operation parameters are algorithm-specific
> > > parameters, output data is the
> > > >  data that should be utilized in operations, and input data is equa=
l to
> > > >  "operation result + result data".
> > > >
> > > > +The device can support both session mode (See \ref{sec:Device Type=
s /
> > > Crypto Device / Device Operation / Control Virtqueue / Session operat=
ion})
> and
> > > non-session mode, for example,
> > > > +As VIRTIO_CRYPTO_F_CIPHER_SESSION feature bit is negotiated, the
> driver
> > > can use session mode for CIPHER service, otherwise it can only use
> non-session
> > > mode.
> > > > +
> > >
> > > As far as I understand you are adding non-session mode to the mix but
> > > providing feature bits for session mode. Would this render the the cu=
rrent
> > > implementation non-compliant?
> > >
> > You are right, shall we use feature bits for non-session mode for compl=
iancy?
> > Or because the spec is on the fly, and some structures in the virtio_cr=
ypto.h
> need to
> > be modified, can we keep the compliancy completely?
> >
> > Thanks,
> > -Gonglei
>=20
> Since there's a linux driver upstream you must at least
> keep compatibility with that.
>=20
Sure. We use feature bits for non-session mode then.
For structures modification, do we need to do some specific
actions for compatibility?  Take CIPHER service as an example:

The present structure:

struct virtio_crypto_cipher_para {
    /*
     * Byte Length of valid IV/Counter data pointed to by the below iv data=
.
     *
     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or fo=
r
     *   SNOW3G in UEA2 mode, this is the length of the IV (which
     *   must be the same as the block length of the cipher).
     * For block ciphers in CTR mode, this is the length of the counter
     *   (which must be the same as the block length of the cipher).
     */
    le32 iv_len;
    /* length of source data */
    le32 src_data_len;
    /* length of destination data */
    le32 dst_data_len;
};

The future structure if supporting non-session based operations:

struct virtio_crypto_cipher_para {
    struct {
        /* See VIRTIO_CRYPTO_CIPHER* above */
        le32 algo;
        /* length of key */
        le32 keylen;

        /* See VIRTIO_CRYPTO_OP_* above */
        le32 op;
    } sess_para;

    /*
     * Byte Length of valid IV/Counter data pointed to by the below iv data=
.
     *
     * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or fo=
r
     *   SNOW3G in UEA2 mode, this is the length of the IV (which
     *   must be the same as the block length of the cipher).
     * For block ciphers in CTR mode, this is the length of the counter
     *   (which must be the same as the block length of the cipher).
     */
    le32 iv_len;
    /* length of source data */
    le32 src_data_len;
    /* length of destination data */
    le32 dst_data_len;
};

Thanks,
-Gonglei
