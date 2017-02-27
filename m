Received: from eggs.gnu.org ([2001:4830:134:3::10]:58541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciLtn-0002wx-KC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciLtl-0007ew-78
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciLtl-0007ed-1l
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:03:33 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35BA2C04B959
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:03:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-13-marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 15:03:30 +0100
In-Reply-To: <20170221141451.28305-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Feb 2017
	18:14:33 +0400")
Message-ID: <87shmzennx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/30] tests: fix bios-tables-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The inside array should be free too.
> Spotted by ASAN.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 54048050c0..d54018da73 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -144,7 +144,7 @@ static void free_test_data(test_data *data)
>          g_free(temp->asl_file);
>      }
>=20=20
> -    g_array_free(data->tables, false);
> +    g_array_free(data->tables, true);
>  }
>=20=20
>  static uint8_t acpi_checksum(const uint8_t *data, int len)

Reviewed-by: Markus Armbruster <armbru@redhat.com>
