Received: from eggs.gnu.org ([2001:4830:134:3::10]:57407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBJ0-0000LP-Ou
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBIw-0007rM-7T
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBIw-0007qq-1G
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1260E6587D
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:42:01 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-20-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <91d59927-971e-1ad3-d426-156f9c3e0aa0@redhat.com>
Date: Tue, 5 Sep 2017 12:41:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-20-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 19/29] postcopy-test: Drop dependence on
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
> Managing parallel connections to two different monitors via
> the implicit global_qtest makes it hard to copy-and-paste code
> to tests that are not aware of the implicit state.  We are
> already half-using the explicit APIs, so fix the remaining
> spots to also be explicit about which connection is in use,
> and avoid global_qtest.
> 
> We can assert that the conversion is correct by checking that
> global_qtest remains NULL throughout the test (a later patch
> that changes global_qtest to not be a public global variable
> will drop the assertions).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/postcopy-test.c | 84 ++++++++++++++++++++++++---------------------------
>  1 file changed, 40 insertions(+), 44 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
