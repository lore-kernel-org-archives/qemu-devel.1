Received: from eggs.gnu.org ([2001:4830:134:3::10]:47182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eo6Xp-0006qI-HC
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eo6Xm-0003aP-GY
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:57:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eo6Xm-0003Zw-Bm
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:57:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53BEDFA46B
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:56:58 +0000 (UTC)
References: <20180212160340.15333-1-dgilbert@redhat.com>
	<20180212160340.15333-3-dgilbert@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <040b3661-52e8-bf66-3751-58e443d03e4d@redhat.com>
Date: Tue, 20 Feb 2018 12:56:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180212160340.15333-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] tests/migration: Add test for
 migration to bad destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com

On 12.02.2018 17:03, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Check the source survives.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/migration-test.c | 65 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 15 deletions(-)
[...]
> @@ -615,6 +649,7 @@ int main(int argc, char **argv)
>  
>      qtest_add_func("/migration/postcopy/unix", test_migrate);
>      qtest_add_func("/migration/deprecated", test_deprecated);
> +    qtest_add_func("/migration/bad_dest", test_baddest);

While running "make check", I now see some "Failed to connect socket:
Connection refused" messages popping up, which is a little bit
confusing. Would it be possible to silence these messages somehow?

 Thomas
