Received: from eggs.gnu.org ([2001:4830:134:3::10]:45487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdbA-0007mV-8X
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdat-000056-QW
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:59:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpdat-0008W6-JN
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:58:59 -0400
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-7-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a731492-7563-b3fa-5a7e-4814af4c7e3b@redhat.com>
Date: Tue, 14 Aug 2018 17:32:50 +0200
MIME-Version: 1.0
In-Reply-To: <1534258018-22859-7-git-send-email-thuth@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 14/08/2018 16:46, Thomas Huth wrote:
> To be able to catch these problems, let's extend the device-introspect
> test to check the devices on all machine types. Since this is a rather
> slow operation, and most of the problems are already handled by testing
> with the "none" machine only, the test with all machines is only run
> in the "make check SPEED=slow" mode.

For a separate series: we should probably do this also for qom-test and
also, somehow (regex?), detect versioned machine types and do the test
with all non-versioned machines unless SPEED=slow.

Paolo
