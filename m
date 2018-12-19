Received: from eggs.gnu.org ([2001:4830:134:3::10]:48196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zgao@suse.com>) id 1gZYDH-0000qn-Pw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zgao@suse.com>) id 1gZYD9-0003M7-Kw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:32:20 -0500
Received: from inet-orm.provo.novell.com ([137.65.248.124]:40527
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zgao@suse.com>) id 1gZYD2-0002GA-Sr
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:32:11 -0500
From: Gao Zhiyuan <zgao@suse.com>
Message-ID: <ddc7219f-98c3-28be-084f-64606452e49b@suse.com>
Date: Wed, 19 Dec 2018 04:31:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Can I have someone's feedback on [bug 1809075]
 Concurrency bug on keyboard events: capslock LED messing up keycode streams
 causes character misses at guest kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi everyone.

Can I please have someone's feedback on this bug? 
https://bugs.launchpad.net/qemu/+bug/1809075
Briefly, guest OS loses characters sent to it via vnc. And I spot the 
bug in relation to ps2 driver.

I'm thinking of possible fixes and I might want to use a memory barrier. 
But I would really like to have some suggestion from a qemu developer 
first. For example, can we brutally drop capslock LED key events in ps2 
queue?

It is actually relevant to openQA, an automated QA tool for openSUSE. 
And this bug blocks a few test cases for us.

Thank you in advance!

Kind regards,
Gao Zhiyuan
