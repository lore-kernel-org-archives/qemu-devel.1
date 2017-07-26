Received: from eggs.gnu.org ([2001:4830:134:3::10]:40139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLAx-0000Iw-JF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLAw-00061f-6R
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daLAv-00060t-US
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0488F285B5
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:12:25 +0000 (UTC)
References: <20170726114437.19624-1-pbonzini@redhat.com>
	<9e187829-fc01-8140-22f0-7cf67fc294bd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f384035-c156-8a75-8909-e6afc692f6af@redhat.com>
Date: Wed, 26 Jul 2017 14:12:22 +0200
MIME-Version: 1.0
In-Reply-To: <9e187829-fc01-8140-22f0-7cf67fc294bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos
 and don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 26/07/2017 13:57, Thomas Huth wrote:
> On 26.07.2017 13:44, Paolo Bonzini wrote:
>> We don't want the page to become too long, but these are good suggestions.
>>
>> Also tone down the sentence about using the latest release or latest git
>> tree, though we do prefer those.
> 
> Well, sometimes people still report bugs against QEMU 2.1 or so ... so
> I'd say everything that is older than the current version - 2 has a very
> high chance to be ignored completely. So maybe we should ask people to
> use at least one of the versions that is mentioned on the front-page of
> www.qemu.org ?

It depends on the bug... for some, the right person might immediately
recognize that it's fixed or that it's just been reported.

Certainly a bug for RHEL6's 0.12 fork is not going to receive much
attention.  But in any case, all these recommendations are advisory
("please try to do the following").

In the end, your recommendation about including the release version or
git hash was somewhat at odds with "make sure you're reporting the bug
against the latest release" (and I actually preferred your version).
Hence the change.

Paolo

>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  contribute.md              |  2 +-
>>  contribute/report-a-bug.md | 13 ++++++++++---
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/contribute.md b/contribute.md
>> index e052654..b10ba7f 100644
>> --- a/contribute.md
>> +++ b/contribute.md
>> @@ -3,7 +3,7 @@ title: Contribute to QEMU!
>>  permalink: /contribute/
>>  ---
>>  
>> -* Report a bug: https://bugs.launchpad.net/qemu/<br>[How to report a bug](report-a-bug/)
>> +* Report a bug: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.net/qemu/)<br>[How to report a bug](report-a-bug/)
>>  
>>  * Clone the git repository: <br>`git clone git://git.qemu-project.org/qemu.git`
>>  
>> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
>> index ce73d76..81eecf7 100644
>> --- a/contribute/report-a-bug.md
>> +++ b/contribute/report-a-bug.md
>> @@ -3,17 +3,24 @@ title: Reporting a bug
>>  permalink: /contribute/report-a-bug/
>>  ---
>>  
>> -Bugs can be filed at our [bug tracker](https://bugs.launchpad.net/qemu/), which is hosted on Launchpad.
>> +Bugs can be filed at our [bug tracker](https://bugs.launchpad.net/qemu/), which is hosted on Launchpad. If you've got a problem with how your Linux distribution packages QEMU, use the bug tracker from your distro instead.
>>  
>>  When submitting a bug report, please try to do the following:
>>  
>> -* Make sure you're reporting the bug against the [latest release](/download/#source).  If possible, please try to reproduce with the latest development tree too.
>> +* Include the QEMU release version or the git commit hash into the description, so that it is later still clear in which version you have found the bug.  Reports against the [latest release](/download/#source) or even the latest development tree are usually acted upon faster.
>>  
>>  * Include the full command line used to launch the QEMU guest.
>>  
>>  * Reproduce the problem directly with a QEMU command-line.  Avoid frontends and management stacks, to ensure that the bug is in QEMU itself and not in a frontend.
>>
> 
> Maybe better "front-end(s)" instead of "frontend(s)" ?
> 
>> -* Include as information about the guest (operating system, version, 32/64-bit).
>> +* Include as information about the host and guest (operating system, version, 32/64-bit).
>>  
>>  * Do not contribute patches on the bug tracker; send patches to the mailing list. Follow QEMU's [guidelines about submitting patches](http://wiki.qemu.org/Contribute/SubmitAPatch).
>>  
>> +Do NOT report security issues (or other bugs, too) as
> 
> Thinking about the markup again, maybe better use "*not*" instead of
> "NOT" (to avoid shouting).
> 
> Apart from that, looks fine to me, thanks for the update!
> 
>  Thomas
> 
