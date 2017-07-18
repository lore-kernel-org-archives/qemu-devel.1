Received: from eggs.gnu.org ([2001:4830:134:3::10]:50424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXOXq-0008Mr-GZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXOXk-00024W-0y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXOXj-00023n-Qh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:11:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7492806A5
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 09:11:46 +0000 (UTC)
References: <20170717063521.GA7393@lemon>
	<b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
	<20170717231721.GE2585@lemon>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f66c4cb9-e024-d874-8e40-7c42eb489d23@redhat.com>
Date: Tue, 18 Jul 2017 11:11:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170717231721.GE2585@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 18.07.2017 01:17, Fam Zheng wrote:
> On Mon, 07/17 11:41, Thomas Huth wrote:
>> On 17.07.2017 08:35, Fam Zheng wrote:
>>> Hi all,
>>>
>>> Today I've included a fourth type of the automatic patchew replies: FreeBSD.
>>>
>>> So far we have these tests running by patchew on each patch series:
>>>
>>>   * Docker tests
>>>     Basically it is
>>>         make docker-test-quick@centos6 \
>>>              docker-test-build@min-glib \
>>>              docker-test-mingw@fedora"
>>>
>>>   * checkpatch.pl
>>>     Each patch is fed to ./scripts/checkpatch.pl and all errors are reported.
>>>
>>>   * s390x
>>>     It runs on a machine shared by Fedora team, basically only "./configure and
>>>     make", because "make check" hanging is tricky to deal with from an
>>>     automation perspective. (Ideas?)
>>
>> Is there any check that could hang "forever"? I think most of the checks
>> should have a proper timeout of one or two minutes, don't they?
>>
>> Maybe you could also simply run the "make check" with the "timeout"
>> command to avoid that it hangs forever?
> 
> Not every operation has a timeout in our tests, with the usual culprit being
> vhost-user-test.
> 
> timeout can terminate make and directly invoked qtest commands, but qemu
> processes that block or hang cannot be cleaned up.

Could the test be rewritten to provide a proper timeout handling
instead? Tests should clearly fail after a while instead of hanging
forever...
Or maybe we could add some magic that the troublesome tests are not
executed if a certain environment variable is set, so we could skip them
in these automated setups here?

 Thomas
