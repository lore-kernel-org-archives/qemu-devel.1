Received: from eggs.gnu.org ([2001:4830:134:3::10]:45027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5VBA-0002ZR-Qr
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5VB5-00024o-W8
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:37:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5VB5-00024Q-Pd
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:37:07 -0400
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
Date: Tue, 2 May 2017 12:37:01 +0200
MIME-Version: 1.0
In-Reply-To: <52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

On 02.05.2017 12:32, Christian Borntraeger wrote:
> On 05/02/2017 12:06 PM, Thomas Huth wrote:
>> The '-enable-...' option do not make too much sense: They do not
>> allow additional parameters, using '-accel xxx' is shorter than
>> '-enable-xxx' and we're also inconsistent here, since there is
>> no '-enable-xen' option available. So let's try to convince the
>> users to use '-accel xxx' instead.
> 
> google has 36000 hits for "--enable-kvm" and 18000 hits for "--accel kvm"
> So I assume this will affect a lot of setups for only a very small benefit.

I'm aware of the fact that likely a lot of users are still using
-enable-kvm, and I did not mean that we should remove it soon yet. But
IMHO we should start now to inform the users that they should slowly
switch to the better option "-accel" instead, so that we could maybe
remove this "-enable-xxx" stuff sometime in the distant future (let's
say QEMU v4.0?).

 Thomas
