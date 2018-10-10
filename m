Received: from eggs.gnu.org ([2001:4830:134:3::10]:39169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAHnf-0002A0-R7
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAHnc-0003vL-Li
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:57:31 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAHnc-0003uq-EW
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:57:28 -0400
Received: by mail-wr1-f43.google.com with SMTP id d2-v6so6551761wro.7
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 09:57:28 -0700 (PDT)
References: <20181010061113.6057-1-armbru@redhat.com>
	<20181010061113.6057-4-armbru@redhat.com>
	<97edaf90-6e1b-92b0-9bcf-3e894328512e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a6358d7-1b38-d20a-56ff-dd8e2b0b3326@redhat.com>
Date: Wed, 10 Oct 2018 18:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <97edaf90-6e1b-92b0-9bcf-3e894328512e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 3/5] tests: Restore check-qdict unit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 10/10/2018 18:43, Eric Blake wrote:
> On 10/10/18 1:11 AM, Markus Armbruster wrote:
>> Commit 0bcc8e5bd8d accidentally dropped check-qdict from the list of
>> unit tests (again, see commit 4429532b48a).  Put it back, and fix up
>> the test.
> 
> Since this seems to be a recurring problem...
> 
>> +++ b/tests/Makefile.include
>> @@ -40,7 +40,7 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
>>     check-unit-y = tests/check-qdict$(EXESUF)
> 
> How about a followup patch that does:
> 
> -   check-unit-y = tests/check-qdict$(EXESUF)
> +   check-unit-y =
> +   check-unit-y += tests/check-qdict$(EXESUF)
> 

Yes, clever :)
