Received: from eggs.gnu.org ([2001:4830:134:3::10]:43715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAedf-0006gA-8d
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAedb-00046L-CO
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:43:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dAedb-00042q-6m
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:43:51 -0400
Date: Tue, 16 May 2017 16:43:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516154317.GS8498@stefanha-x1.localdomain>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-6-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ShzQXCswyqjgWi6k"
Content-Disposition: inline
In-Reply-To: <1494243504-127980-6-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [RFC v1 5/9] virtio-crypto: update header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, weidong.huang@huawei.com, pasic@linux.vnet.ibm.com, luonengjun@huawei.com, cornelia.huck@de.ibm.com, linqiangmin@huawei.com, xin.zeng@intel.com, wu.wubin@huawei.com


--ShzQXCswyqjgWi6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 08, 2017 at 07:38:20PM +0800, Gonglei wrote:
> @@ -166,8 +175,8 @@ struct virtio_crypto_aead_session_para {
>  	uint32_t algo;
>  	/* length of key */
>  	uint32_t key_len;
> -	/* hash result length */
> -	uint32_t hash_result_len;
> +	/* Authentication tag length */
> +	uint32_t tag_len;

Why is this field being renamed?

--ShzQXCswyqjgWi6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGx4VAAoJEJykq7OBq3PIqBMH/27V6ML/6tEtgzgDIorLUIBw
Izpuys5BEoalnrMcPsViNMh5740k2/vhMdFb5DHHp9BYKiw+kvezuv3gWXMWwwl6
cAFrKOfN03/hR3HqSKkLid4iKkGN1x28+voxTRxtuvVhoscddpCkTo5XZbqnqBf2
bBxsCfXCg8dpwV+A2MpG8iSZjrBW9FL/LSkf8zu+GGxfIvgxyC43DUAQIkxQWr4H
oO7uXeVUvG7sVYYLee9PLiPZ7wn/4JaJeMojEgogNZI1YH21bAZ0mdlRroZpXJWB
1l9KRz9a54uf5NFrCDKk8pzwDQnhg1lwgr07JqyVsyvO8vVttOQC+pOKAoGB++k=
=zfc8
-----END PGP SIGNATURE-----

--ShzQXCswyqjgWi6k--
