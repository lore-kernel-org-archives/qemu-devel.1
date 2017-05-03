Received: from eggs.gnu.org ([2001:4830:134:3::10]:47674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5sqH-0007cQ-Na
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5sqE-00027y-MM
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:53:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5sqE-00027h-EW
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:53:10 -0400
References: <20170503094351.5040-1-pbonzini@redhat.com>
	<20170503094351.5040-3-pbonzini@redhat.com>
	<e3916e2f-d41a-7920-3256-1a386f05e527@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d392e456-1882-bef0-9fd5-553b3ccd598f@redhat.com>
Date: Wed, 3 May 2017 13:53:04 +0200
MIME-Version: 1.0
In-Reply-To: <e3916e2f-d41a-7920-3256-1a386f05e527@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] get_maintainer: Teach
 get_maintainer.pl about the new "R:" tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pavel.dovgaluk@ispras.ru



On 03/05/2017 12:45, Thomas Huth wrote:
> On 03.05.2017 11:43, Paolo Bonzini wrote:
>> From: Joe Perches <joe@perches.com>
>>
>> We can now designate reviewers in the MAINTAINERS file with the new
>> "R:" tag, so this commit teaches get_maintainers.pl to add their
>> email addresses.
>>
>> Cherry picked from Linux commit c1c3f2c906e35bcb6e4cdf5b8e077660fead14fe,
>> with fixes to avoid \C as in QEMU commit ba10f729f1 ("get_maintainer.pl:
>> \C is deprecated", 2015-09-25).
> 
> Upstream linux.git changed it to [A-Z] in commit ce8155f7a ... so maybe
> use that in QEMU, too, so we stay closer to the Linux version?

We used "." in ba10f729f1, so I stayed consistent with that one.  But we
could also change those periods to [A-Z] en masse.

Paolo
