Received: from eggs.gnu.org ([2001:4830:134:3::10]:43017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpGXA-00074p-J9
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpGX5-0006VT-UG
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:17:04 -0400
Date: Tue, 5 Sep 2017 18:16:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905161643.GO4633@localhost.localdomain>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-7-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132028.6184-7-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v9 6/6] qemu-iotests: add 184 for throttle
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 25.08.2017 um 15:20 hat Manos Pitsidianakis geschrieben:
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Does this test actually (still) pass for you? I can't see that it's
related to any recent change in master, but this is the diff that I get.

I can update the reference output while applying, but obviously if it's
currently passing for you, it will fail after I "fix" it.

Kevin


184                [18:07:39] [18:07:39] - output mismatch (see 184.out.bad)
--- /home/kwolf/source/qemu/tests/qemu-iotests/184.out  2017-09-05 18:07:30.751340633 +0200
+++ 184.out.bad 2017-09-05 18:07:39.707341854 +0200
@@ -30,8 +30,10 @@
             "image": {
                 "virtual-size": 67108864,
                 "filename": "json:{\"throttle-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+                "cluster-size": 65536,
                 "format": "throttle",
-                "actual-size": 200704
+                "actual-size": 200704,
+                "dirty-flag": false
             },
             "iops_wr": 0,
             "ro": false,
