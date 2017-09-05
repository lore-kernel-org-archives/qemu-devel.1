Received: from eggs.gnu.org ([2001:4830:134:3::10]:39574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBZu-0007JW-5g
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBZp-0005cP-Ir
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBZp-0005bL-Cz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 305CC7E428
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:59:28 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-25-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <941b7e45-7dfc-8e35-18e0-12b247481d1e@redhat.com>
Date: Tue, 5 Sep 2017 12:59:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-25-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 24/29] bios-tables-test: Drop dependence
 on global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 01.09.2017 20:03, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  Although bios-tables-test does
> not maintain parallel qtest connections, it's just as easy to be
> explicit about the state; once all tests have been cleaned up, a
> later patch can then get rid of global_qtest and a layer of
> wrappers in libqtest.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/bios-tables-test.c | 78 +++++++++++++++++++++++++-----------------------
>  1 file changed, 40 insertions(+), 38 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 75b29df493..976792f2c5 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -38,6 +38,7 @@ typedef struct {
>      struct smbios_21_entry_point smbios_ep_table;
>      uint8_t *required_struct_types;
>      int required_struct_types_len;
> +    QTestState *qts;
>  } test_data;

Ah, well, ok, here it is. Please merge this with the previous patch!

 Thomas
