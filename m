Received: from eggs.gnu.org ([2001:4830:134:3::10]:37753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafCd-0001wi-MI
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafCa-0007pK-HU
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:03:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cafCa-0007p8-CD
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:03:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C901183F38
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 09:03:11 +0000 (UTC)
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-6-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36848fad-c7b9-21e3-0c6e-78014e9580c4@redhat.com>
Date: Mon, 6 Feb 2017 10:03:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170202145141.17138-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/22] main: free root container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
> This should eventually free all objects that are only referenced by
> their parents.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  vl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/vl.c b/vl.c
> index 0b72b12878..945df1d17f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4640,6 +4640,7 @@ int main(int argc, char **argv, char **envp)
>      audio_cleanup();
>      monitor_cleanup();
>      qemu_chr_cleanup();
> +    object_unref(object_get_root());

This seems dangerous.  I'm pretty sure that a lot of non-hot-unpluggable
devices would leak or crash.

Paolo
