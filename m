Received: from eggs.gnu.org ([2001:4830:134:3::10]:43227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkFgK-0006Fx-Tr
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkFgK-00006P-56
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:26:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fkFgK-00006E-01
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:26:20 -0400
References: <20180723193530.20891-1-eblake@redhat.com>
	<a040b798-b864-c48a-2a8c-c19565f262ca@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <720e8737-7b43-c3c4-f8f8-30b68e5a2709@redhat.com>
Date: Mon, 30 Jul 2018 16:26:16 -0500
MIME-Version: 1.0
In-Reply-To: <a040b798-b864-c48a-2a8c-c19565f262ca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.0] tests/libqtest: Improve
 kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, alex.bennee@linaro.org, f4bug@amsat.org, mst@redhat.com

On 07/24/2018 01:44 AM, Thomas Huth wrote:

>>
>> Furthermore, we are NOT detecting EINTR (while EINTR shouldn't be
>> happening if we didn't install signal handlers, it's still better
>> to always be robust), and also want to log unexpected non-zero status
>> that was not accompanied by a core dump.
>>

>>           kill(s->qemu_pid, SIGTERM);
>> +    retry:
>>           pid = waitpid(s->qemu_pid, &wstatus, 0);
>> +        if (pid == -1 && errno == EINTR) {
>> +            goto retry;
>> +        }
> 
>      do {
>          pid = waitpid(s->qemu_pid, &wstatus, 0);
>      } while (pid == -1 && errno == EINTR);
> 
> ?
> 
> Or use the TFR macro from include/qemu-common.h ?

Cool, I didn't know that macro existed! Will send v3.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
