Received: from eggs.gnu.org ([2001:4830:134:3::10]:46225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1TQE-0001XT-VM
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1TQ9-0001ft-SG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e1TQ9-0001ff-Ln
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:28:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 858C3820EB
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 08:28:16 +0000 (UTC)
Date: Mon, 9 Oct 2017 16:28:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171009082812.GE2196@pxdev.xzpeter.org>
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004103933.7898-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Add migration compress threads
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Oct 04, 2017 at 12:39:32PM +0200, Juan Quintela wrote:

[...]

>  int main(int argc, char **argv)
>  {
> @@ -641,6 +689,9 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
>      qtest_add_func("/migration/deprecated/unix", test_deprecated_unix);
>      qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);

Nits: Not sure whether we can have better naming for the tests?  Say:

  /migration/precopy/unix
  /migration/precopy/tcp
  /migration/deprecated-cmds
  /migration/xbzrle
  /migration/compression

I'm fine with existing naming as well.

For the deprecated commands test, not sure whether we can just send
those commands and query using "query-migrate-parameters" to make sure
they are setup and valid.  I assume it can be faster than real
migrations.

> +    if (0) {

Is this intended? :)

> +        qtest_add_func("/migration/compress/unix", test_compress_unix);
> +    }
>  
>      ret = g_test_run();
>  
> -- 
> 2.13.5
> 

Thanks,

-- 
Peter Xu
