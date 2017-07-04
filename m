Received: from eggs.gnu.org ([2001:4830:134:3::10]:59028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSN2j-0001J2-Qs
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSN2g-0000fm-05
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSN2f-0000fU-QA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:34:57 -0400
References: <20170704111404.28569-1-berrange@redhat.com>
	<f22d82b6-cd4b-b71c-179e-2f590ddb19b8@redhat.com>
	<20170704122738.GM3135@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <687a9a9a-5419-a7fe-3d14-6e71f2f4a735@redhat.com>
Date: Tue, 4 Jul 2017 14:34:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170704122738.GM3135@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Document deprecated features &
 support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 04.07.2017 14:27, Daniel P. Berrange wrote:
> On Tue, Jul 04, 2017 at 02:21:28PM +0200, Thomas Huth wrote:
>> On 04.07.2017 13:14, Daniel P. Berrange wrote:
>> [...]
>>>  - Not listing the '-6' and '-e' args to qemu-img create. Those
>>>    were never deprecations, because the functionality was
>>>    immediately turned into a fatal error.
>> How did you come to that conclusion? As far as I can see, the -6 option
>> has been added by commit ec36ba14748e140dda2 and that was part of QEMU
>> v0.10. The deprecation was done in commit eec77d9e712bd415 and that was
>> part of QEMU v0.14.
> 
> A 'deprecation' message implies that the functionality continues to
> work, but the user gets a warning that its going away. In this case
> the user gets a warning, and the functionality is unusable - qemu-img
> just exits immediately. This isn't deprecation in any normal sense,
> it is just immediate feature removal with an message telling you it
> has already been deleted :-(

Ah, right, of course ... I somehow read your original sentence that the
functionality would have been added in one release cycle and also
removed again in the same cycle, that's why I was confused, but it makes
sense now. So yes, should be fine to remove this code immediately now.

 Thomas
