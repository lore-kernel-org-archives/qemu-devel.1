Received: from eggs.gnu.org ([2001:4830:134:3::10]:51192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLAHG-0006IY-Cd
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLAHA-0007Vd-Qx
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:09:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gLAHA-0007Da-AX
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:08:56 -0500
References: <20181109153002.597-1-crosa@redhat.com>
	<20181109153002.597-2-crosa@redhat.com>
	<20181109155640.GA12624@flamenco>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <cff78fc4-cd40-9498-c26a-068344ae19b7@redhat.com>
Date: Fri, 9 Nov 2018 12:08:13 -0500
MIME-Version: 1.0
In-Reply-To: <20181109155640.GA12624@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] tests/test-qht-par: test gets
 stuck intermittently on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, programmingkidx@gmail.com, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 11/9/18 10:56 AM, Emilio G. Cota wrote:
> On Fri, Nov 09, 2018 at 10:30:01 -0500, Cleber Rosa wrote:
>> To be fully honest, this may not be a OSX (alone) condition, but may
>> be a situation that only happens with OSX on Travis-CI, were resources
>> are quite limited.
>>
>> I have personal experience with tests that exercise parallelism or
>> depend on timing to fail on Travis.  Because I'm not 100% certain that
>> this is a situation that only happens with OSX on Travis-CI, and
>> because I'm not certain that we should be skipping tests because
>> they're running on Travis-CI, let's disable them on OSX as a whole.
>>
>> A small note: this type of change makes me believe that there should
>> be a list of testing related caveats or TODO list tracked on the
>> documentation.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> 
> Is there a way to know where it hangs?
> 
> Also, are these the g_test_quick tests, or the other ones? It it's
> just a matter of the program taking too long to run, we could just
> reduce the length of the !quick tests (currently at 5s vs. 1s for
> the quick ones).
> 
> Thanks,
> 
> 		Emilio
> 

Looks like the common cause was fixed a458774ad711bceabefb, as pointed
out by Peter.

- Cleber.
