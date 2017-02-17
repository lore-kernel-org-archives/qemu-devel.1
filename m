Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cep6n-0000b4-5p
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cep6j-0000AX-UR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:26:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cep6j-0000A6-OG
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:26:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170217172607.25575-1-danielhb@linux.vnet.ibm.com>
	<3c2ce558-db56-79b5-14ed-4431f6529c82@redhat.com>
	<6fe6a499-faa2-1e3d-a419-d33b2e538e7c@linux.vnet.ibm.com>
	<1867aaa8-57ba-0223-3b28-bac569f6f9de@redhat.com>
Date: Fri, 17 Feb 2017 21:26:18 +0100
In-Reply-To: <1867aaa8-57ba-0223-3b28-bac569f6f9de@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 13:38:07 -0600")
Message-ID: <87wpcoa7it.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 02/17/2017 01:01 PM, Daniel Henrique Barboza wrote:
>
>>>> 2000000)) {
>>>> +        (params->downtime_limit < 0 ||
>>>> +         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
>>>>           error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>>>>                      "downtime_limit",
>>>> -                   "an integer in the range of 0 to 2000000
>>>> milliseconds");
>>>> +                   "an integer in the range of 0 to 2000 seconds");
>>> Perhaps you could use %d and set  MAX_MIGRATE_SET_DOWNTIME to 2000?
>>> Though perhaps the migration maintainers are okay with the patch as is.
>> 
>> I did that at first but I got errors on "error_setg" about the extra
>> parameter.
>
> Ah, right, because QERR_INVALID_PARAMETER_VALUE is a macro that expands
> to a fixed printf-style format string where you have to know how many
> exact arguments it further expects.  The only way around that is to
> open-code the error message you want, instead of forcing the use of the
> awkward macro.

Go ahead and open-code whenever that results in better error messages.
