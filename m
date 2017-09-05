Received: from eggs.gnu.org ([2001:4830:134:3::10]:35035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBQ5-0004sz-6C
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBQ0-0004v4-N5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBQ0-0004ux-HP
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:49:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67E86C0587D1
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:49:19 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-21-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0703dbd9-d6f2-9ac1-d1dd-5b11005e67b6@redhat.com>
Date: Tue, 5 Sep 2017 12:49:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-21-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 20/29] vhost-user-test: Drop dependence
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
Cc: pbonzini@redhat.com, armbru@redhat.com

On 01.09.2017 20:03, Eric Blake wrote:
> Managing parallel connections to two different monitors via
> the implicit global_qtest makes it hard to copy-and-paste code
> to tests that are not aware of the implicit state.  Now that
> libqos is fully-explicit, it is easy to expand the rest of
> vhost-user-test to also use explicit state everywhere.
> 
> We can assert that the conversion is correct by checking that
> global_qtest remains NULL throughout the test (a later patch
> that changes global_qtest to not be a public global variable
> will drop the assertions).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/vhost-user-test.c | 68 ++++++++++++++++++++++---------------------------
>  1 file changed, 30 insertions(+), 38 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
