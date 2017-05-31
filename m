Received: from eggs.gnu.org ([2001:4830:134:3::10]:44477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG0K0-0002Pc-K4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG0Jw-0005Ge-OD
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:53:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dG0Jw-0005GU-IQ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:53:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87C3585543
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:53:39 +0000 (UTC)
Date: Wed, 31 May 2017 10:53:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170531095326.GF2141@work-vm>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-12-git-send-email-vyasevic@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495649128-10529-12-git-send-email-vyasevic@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/12] tests/test-hmp: Add announce
 parameter tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

* Vladislav Yasevich (vyasevic@redhat.com) wrote:
> Add 2 new commands for announce parameters to the test.
> 
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> ---
>  tests/test-hmp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 99e35ec..f3887d1 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -65,6 +65,8 @@ static const char *hmp_cmds[] = {
>      "sum 0 512",
>      "x /8i 0x100",
>      "xp /16x 0",
> +    "info announce_parameters",

I don't think you need to do that, test_info_commands
gets the list of info commands and calls them all.

Dave

> +    "announce_set_parameter rounds 10",
>      NULL
>  };
>  
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
