Received: from eggs.gnu.org ([2001:4830:134:3::10]:57111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGNV-000581-5N
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGNQ-0006AZ-6I
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:23:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqGNQ-0006AP-0P
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:23:40 -0400
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-7-git-send-email-thuth@redhat.com>
	<9a731492-7563-b3fa-5a7e-4814af4c7e3b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7c557b69-080f-b1d8-4490-bcabade4cb88@redhat.com>
Date: Thu, 16 Aug 2018 13:23:34 +0200
MIME-Version: 1.0
In-Reply-To: <9a731492-7563-b3fa-5a7e-4814af4c7e3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] tests/device-introspect: Test with all
 machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 08/14/2018 05:32 PM, Paolo Bonzini wrote:
> On 14/08/2018 16:46, Thomas Huth wrote:
>> To be able to catch these problems, let's extend the device-introspect
>> test to check the devices on all machine types. Since this is a rather
>> slow operation, and most of the problems are already handled by testing
>> with the "none" machine only, the test with all machines is only run
>> in the "make check SPEED=slow" mode.
> 
> For a separate series: we should probably do this also for qom-test and
> also, somehow (regex?), detect versioned machine types and do the test
> with all non-versioned machines unless SPEED=slow.

I'll include a patch for this in v2 of my patch series.

 Thomas
