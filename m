Received: from eggs.gnu.org ([2001:4830:134:3::10]:42474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBgE-00021T-Av
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBg5-0003fh-1N
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBg4-0003fB-S5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F171261475
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 11:05:55 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-27-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a6e44bb3-c858-3277-4bdc-50dddf19981f@redhat.com>
Date: Tue, 5 Sep 2017 13:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-27-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 26/29] fw_cfg-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 01.09.2017 20:03, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  It turns out that with the
> recent changes to libqos, fw_cfg-test was not even using
> global_qtest any more.  Avoid a pointless strdup while at it.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/fw_cfg-test.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 47596c57a1..3a8dc7a2cd 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -102,14 +102,11 @@ static void test_fw_cfg_boot_menu(void)
>  int main(int argc, char **argv)
>  {
>      QTestState *s;
> -    char *cmdline;
>      int ret;
> 
>      g_test_init(&argc, &argv, NULL);
> 
> -    cmdline = g_strdup_printf("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 ");
> -    s = qtest_start(cmdline);
> -    g_free(cmdline);
> +    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> 
>      fw_cfg = pc_fw_cfg_init(s);
> 

Why don't you merge this with patch 14/29?

 Thomas
