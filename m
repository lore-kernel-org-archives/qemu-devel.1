Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C695C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9662067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9662067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dfR-00070j-5o
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7dX4-00072U-IH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7dX2-0001yJ-Iz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7dWv-0001tl-8F; Tue, 10 Sep 2019 06:37:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 031AA30BCB87;
 Tue, 10 Sep 2019 10:37:43 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBCE15DA5B;
 Tue, 10 Sep 2019 10:37:39 +0000 (UTC)
Message-ID: <b15947a62510325bddec093a2f80e86704a81641.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 13:37:38 +0300
In-Reply-To: <5608ea37-e3d4-0e9c-039c-5311c8b8d531@redhat.com>
References: <676393243dbf38470b514a8dc11024380ff836d8.camel@redhat.com>
 <5608ea37-e3d4-0e9c-039c-5311c8b8d531@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 10 Sep 2019 10:37:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] IOTEST 162
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-09 at 13:24 -0400, John Snow wrote:
> 
> On 9/6/19 1:25 PM, Maxim Levitsky wrote:
> > Hi!
> > 
> > I just had a very fun rabbit hole dive, and I want to share it with you.
> > 
> > I notice for some time that iotest 162 fails with that:
> > 
> > -qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to connect socket: Invalid argument
> > +qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to connect socket:
> > Connection timed out
> > 
> > 
> > I didn't bother to report it yet as it started failing more or less when qemu 4.2 merge window opened,
> > so I thought that maybe something got broken, or maybe something broken in my environment 
> > (ahem, AF_UNIX path is too long, ahem)
> > 
> > I just didn't had enough time to pay attention to this. Until today.
> > 
> > So I asked Kevin Wolf today, just by the way why I see for some time that
> > iotest 162 fails. for me.
> > 
> > 
> > He told me that it works for him.
> > So I look at the test and I see that it just does
> > 
> > qemu-img info 'json:{"driver": "nbd", "host": 42}'
> > 
> > Supposedly it should fail because 42 is not quoted, and it 
> > doesn't look like a valid host name.
> > 
> > I try with disto's qemu-img (2.11) and I still see that I get the 'Connection timed out'
> > 
> > Then I ask him to try on his system with '42' quoted and it still passes.
> > 
> > All right - this means that this 42 is parsed. He also mentions that he uses fedora 29 and I still
> > use fedora 28. So I start a VM with fedora 30, and yep, there it does work correctly.
> > 
> > All right, that 42 must be parsed as a host name. Yep. 'ping 42' on my machine tries to ping 0.0.0.42,
> > and in VM exits immediately with 'Invalid argument'
> > All right, lets ping 0.0.0.42. Maybe something in hostname parsing changed, maybe something parses this on DNS level?
> > Nope, ping 0.0.0.42 works on my machine, fails with invalid argument in VM...
> > 
> > All right lets strace it
> > 
> > connect(5, {sa_family=AF_INET, sin_port=htons(1025), sin_addr=inet_addr("0.0.0.42")}, 16) = -1 EINVAL (Invalid argument)
> > 
> > Same thing passes on my machine....
> > 
> > Hmm... this is something in the kernel. Maybe something in iptables/etc. I don't yet know that
> > area that well to be honest.
> > 
> > So I googled a bit and look what I found:
> > 
> > https://lwn.net/Articles/791086/
> > 
> > And yes, while my machine runs fedora 28, it as usual runs vanilla git master
> > kernel, which I compile from time to time. Currently I am on 5.3.0-rc4+.
> > 
> > So I must say that nothing less but kernel 5.3.0, breaks iotest 162.
> > 
> > I''l prepare a patch soon to fix this.
> 
> I wonder if I am seeing some related problems, though I am running
> 5.2.11 right now and not 5.3.x:
> 
> 162 is failing in this way:
> 
> -qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost",
> "port": "0", "path": "/foo"}': Failed to connect socket: Connection refused
> -qemu-img: Could not open 'driver=ssh,host=localhost,port=0,path=/foo':
> Failed to connect socket: Connection refused
> +qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost",
> "port": "0", "path": "/foo"}': Failed to connect socket: Connection
> timed out
> +qemu-img: Could not open 'driver=ssh,host=localhost,port=0,path=/foo':
> Failed to connect socket: Connection timed out
>  qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost",
> "port": 0.42, "path": "/foo"}': Parameter 'port' expects a number
>  qemu-img: Could not open
> 'driver=ssh,host=localhost,port=0.42,path=/foo': Parameter 'port'
> expects a number

This must be the same issue, although here it fails like that:


[mlevitsk@maximlenovopc ~/qemu/tests/qemu-iotests]$./check -qcow2 162
QEMU          -- "/home/mlevitsk/qemu/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -display none -machine accel=qtest
QEMU_IMG      -- "/home/mlevitsk/qemu/tests/qemu-iotests/../../qemu-img" 
QEMU_IO       -- "/home/mlevitsk/qemu/tests/qemu-iotests/../../qemu-io"  --cache writeback -f qcow2
QEMU_NBD      -- "/home/mlevitsk/qemu/tests/qemu-iotests/../../qemu-nbd" 
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 maximlenovopc 5.3.0-rc4+
TEST_DIR      -- /home/mlevitsk/qemu/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- /home/mlevitsk/qemu/tests/qemu-iotests/socket_scm_helper

162      fail       [12:25:07] [12:27:18]                    output mismatch (see 162.out.bad)
--- /home/mlevitsk/USERSPACE/qemu/src/tests/qemu-iotests/162.out	2019-04-07 16:37:54.656311574 +0300
+++ /home/mlevitsk/qemu/tests/qemu-iotests/162.out.bad	2019-09-10 12:27:18.032903571 +0300
@@ -1,7 +1,7 @@
 QA output created by 162
 
 === NBD ===
-qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to connect socket: Invalid argument
+qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to connect socket: Connection timed out
 image: nbd://localhost:PORT
 image: nbd+unix://?socket=42
 
Failures: 162
Failed 1 of 1 tests



Test 147 passes for me with both raw and qcow2 format.

Best regards,
	Maxim Levitsky


> 
> 
> and 147 is failing this way:
> 
> +  File "147", line 243, in test_inet6
> +    if self._try_server_up(address):
> +  File "147", line 156, in _try_server_up
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/bos/jhuston/src/qemu/tests/qemu-iotests/iotests.py", line
> 685, in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/home/bos/jhuston/src/qemu/tests/qemu-iotests/iotests.py", line
> 661, in dictpath
> +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': 'Failed to bind socket: Cannot assign
> requested address'}}"
> 
> 
> 
> I'm not sure when the failure started -- this is the first time I'm
> seeing it -- I'm fairly certain I ran these tests Thursday or Friday
> last week.



