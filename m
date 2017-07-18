Received: from eggs.gnu.org ([2001:4830:134:3::10]:44680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXYPN-00083g-Pb
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXYPM-0000UG-RU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:43:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
	<c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
	<87y3rlrct2.fsf@dusky.pond.sub.org>
Date: Tue, 18 Jul 2017 21:43:40 +0200
In-Reply-To: <87y3rlrct2.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 18 Jul 2017 17:21:13 +0200")
Message-ID: <87lgnlcyz7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 07/18/2017 09:53 AM, Eric Blake wrote:
>>> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>>>> I expect the 'null' type to be useful mostly for members of alternate
>>>> types.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>> 
>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Actually, do we need to update any qapi docs to mention the new builtin
>> type?
>
> Yes, we do.  I'll give it a shot.

Incremental patch appended.  May I keep your R-by?


diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 52e3874..6d8e00c 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -283,6 +283,7 @@ The following types are predefined, and map to C as follows:
                        accepts size suffixes
   bool      bool       JSON true or false
   any       QObject *  any JSON value
+  null      QNull *    JSON null
   QType     QType      JSON string matching enum QType values
 
 
@@ -536,10 +537,11 @@ can only express a choice between types represented differently in
 JSON.  If a branch is typed as the 'bool' built-in, the alternate
 accepts true and false; if it is typed as any of the various numeric
 built-ins, it accepts a JSON number; if it is typed as a 'str'
-built-in or named enum type, it accepts a JSON string; and if it is
-typed as a complex type (struct or union), it accepts a JSON object.
-Two different complex types, for instance, aren't permitted, because
-both are represented as a JSON object.
+built-in or named enum type, it accepts a JSON string; if it is typed
+as the 'null' built-in, it accepts JSON null, and if it is typed as a
+complex type (struct or union), it accepts a JSON object.  Two
+different complex types, for instance, aren't permitted, because both
+are represented as a JSON object.
 
 The example alternate declaration above allows using both of the
 following example objects:
