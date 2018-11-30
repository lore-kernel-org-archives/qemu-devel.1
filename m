Received: from eggs.gnu.org ([2001:4830:134:3::10]:56918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSX8u-00043J-U5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSX8q-0006HS-TF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:58:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSX8q-0006Fa-N3
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:58:48 -0500
References: <20181129180050.17797-1-pbonzini@redhat.com>
	<8fcdeb08-d87c-a236-de94-f5129aa3b99b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4464faa8-7191-8898-e5fb-8e4700bd2693@redhat.com>
Date: Thu, 29 Nov 2018 18:58:47 -0600
MIME-Version: 1.0
In-Reply-To: <8fcdeb08-d87c-a236-de94-f5129aa3b99b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] glib-compat: work around g_test_message
 bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 11/29/18 6:08 PM, Paolo Bonzini wrote:
> On 29/11/18 19:00, Paolo Bonzini wrote:
>> Subprocesses are created by glib without leaving the file descriptors
>> open.  Therefore, g_test_message (and assertion failures, but those
>> trigger when things are going bad anyway) will think that it is writing
>> to the log file descriptor, but while actually stomping on the QMP
>> file descriptor or similar.  This causes spurious failures, which are
>> as nice to debug as the reader can imagine.  While I have opened a
>> pull request on GLib, this will probably take a while to propagate
>> to distros.
>>
>> I found this while working on qgraph, but the fix is generic.
> 
> This is not a problem anymore if we switch from gtester to tap.  Do we
> want it fixed anyway or not?

If there is no -rc4, I'm fine if we drop this patch in favor of your 
other patches for TAP. But if we have -rc4, this may still be useful for 
inclusion in 3.1 for testsuite robustness.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
