Received: from eggs.gnu.org ([2001:4830:134:3::10]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnPdp-0003gH-NV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnPdm-0008Aw-LI
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:36:17 -0400
References: <1503941985-25657-1-git-send-email-thuth@redhat.com>
	<20170830154803.46bc99fc@nial.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0cf2b541-a9da-ddbf-bfe4-fe0bb24327c1@redhat.com>
Date: Thu, 31 Aug 2017 15:35:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170830154803.46bc99fc@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests/bios-tables: Silence some
 messages with V=1, print them with V=2 only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 30.08.2017 15:48, Igor Mammedov wrote:
> On Mon, 28 Aug 2017 19:39:45 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> When running "make check-qtest-x86_64 V=1", the output is currently flooded
>> with "Looking for expected file ..." and "Using expected file ..." messages.
>> None of the other tests is doing that with V=1, so this is a little bit
>> annoying. Let's only print these debug messages when we're running the test
>> with V=2 or higher.
> well, normally make check is run without V=
> and if someone once in a while need to run it in verbose mode,
> he/she can tolerate it since it's a verbose mode after all.
> 
> Hiding message behind V=XX is going to make us remember/recall
> at which verbosity level one needs to run tests to get needed
> diagnostic info.
> 
> I'd rather keep it as it is now.

Well, I love to run the tests with V=1, especially as soon as one of the
tests hangs. But the output of the bios-tables-test really breaks the
well-formatted output of the test framework in that case, so adding a
V=2 debug level is IMHO a good idea. But if I'm the only who's annoyed
by the current output of the bios-tables-test, feel free to ignore me ;-)

 Thomas
