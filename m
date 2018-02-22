Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eolUx-0002sW-CL
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eolUu-0002st-9l
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:40:59 -0500
Received: from m15-47.126.com ([220.181.15.47]:52501)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1eolUt-0002b8-Fz
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:40:56 -0500
Date: Thu, 22 Feb 2018 15:40:44 +0800 (CST)
From: "Chen Hanxiao" <chen_han_xiao@126.com>
In-Reply-To: <151872008505.15399.14198607718964730192@sif>
References: <20180209013542.24516-1-chen_han_xiao@126.com>
	<151872008505.15399.14198607718964730192@sif>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3b9029f0.2ab6.161bc75118f.Coremail.chen_han_xiao@126.com>
Subject: Re: [Qemu-devel] [Resend][PATCH] qga: unset frozen state if no
 mount points are frozen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

CkF0IDIwMTgtMDItMTYgMDI6NDE6MjUsICJNaWNoYWVsIFJvdGgiIDxtZHJvdGhAbGludXgudm5l
dC5pYm0uY29tPiB3cm90ZToKPlF1b3RpbmcgQ2hlbiBIYW54aWFvICgyMDE4LTAyLTA4IDE5OjM1
OjQyKQo+PiBGcm9tOiBDaGVuIEhhbnhpYW8gPGNoZW5oYW54aWFvQGdtYWlsLmNvbT4KPj4gCj4+
IElmIHdlIHNldCBtb3VudHBvaW50cyB0byBxbXBfZ3Vlc3RfZnNmcmVlemVfZnJlZXplX2xpc3Qs
Cj4+IHdlIG1heSBnb3Qgbm90aGluZyB0byBmcmVlemUgYXMgYWxsIG1vdW50cG9pbnRzIGFyZQo+
PiBub3QgdmFsaWQuCj4+IENhbGwgZ2FfdW5zZXRfZnJvemVuIGluIHRoaXMgc2VuYXJpby4KPj4g
Cj4+IENjOiBNaWNoYWVsIFJvdGggPG1kcm90aEBsaW51eC52bmV0LmlibS5jb20+Cj4+IFNpZ25l
ZC1vZmYtYnk6IENoZW4gSGFueGlhbyA8Y2hlbmhhbnhpYW9AZ21haWwuY29tPgo+PiAtLS0KPj4g
UmViYXNlIG9uIG1hc3Rlcgo+PiAKPj4gIHFnYS9jb21tYW5kcy1wb3NpeC5jIHwgNiArKysrKysK
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9x
Z2EvY29tbWFuZHMtcG9zaXguYyBiL3FnYS9jb21tYW5kcy1wb3NpeC5jCj4+IGluZGV4IGU4MDll
MzgyZWIuLjlmZDUxZjFkN2EgMTAwNjQ0Cj4+IC0tLSBhL3FnYS9jb21tYW5kcy1wb3NpeC5jCj4+
ICsrKyBiL3FnYS9jb21tYW5kcy1wb3NpeC5jCj4+IEBAIC0xMjczLDYgKzEyNzMsMTIgQEAgaW50
NjRfdCBxbXBfZ3Vlc3RfZnNmcmVlemVfZnJlZXplX2xpc3QoYm9vbCBoYXNfbW91bnRwb2ludHMs
Cj4+ICAgICAgfQo+PiAKPj4gICAgICBmcmVlX2ZzX21vdW50X2xpc3QoJm1vdW50cyk7Cj4+ICsg
ICAgLyogV2UgbWF5IG5vdCBpc3N1ZSBhbnkgRklGUkVFWkUgaGVyZSB3aGVuIGhhZCBtb3VudHBv
aW50cy4KPj4gKyAgICAgKiBKdXN0IHVuc2V0IGdhX3N0YXRlIGhlcmUgYW5kIHJlYWR5IGZvciB0
aGUgbmV4dCBjYWxsLgo+PiArICAgICAqLwo+PiArICAgIGlmIChoYXNfbW91bnRwb2ludHMgJiYg
aSA9PSAwKSB7Cj4+ICsgICAgICAgIGdhX3Vuc2V0X2Zyb3plbihnYV9zdGF0ZSk7Cj4+ICsgICAg
fQo+Cj5JdCBzZWVtcyBvZGQgdG8gc3BlY2lhbC1jYXNlIGhhc19tb3VudHBvaW50cy4gV291bGRu
J3Q6Cj4KPiAgaWYgKGkgPT0gMCkgewo+ICAgIC4uLgo+ICB9Cj4KPmJlIG1vcmUgY29uc2lzdGVu
dD8gVGhlbiBtYW5hZ2VtZW50IGNvdWxkIGluZmVyIGk9PTAgbGVhdmVzIHFnYSBpbgo+dW5mcm96
ZW4gc3RhdGUuIE90aGVyd2lzZSBJJ2QgcmF0aGVyIGp1c3Qgc3RpY2sgd2l0aCBleHBlY3Rpbmcg
YQo+Z3JhdHVpdG91cyB1bmZyZWV6ZSgpIHNpbmNlIGl0IHJlcXVpcmVzIGxlc3Mgc3BlY2lhbC1j
YXNpbmcgb24gdGhlCj5tYW5hZ2VtZW50LyBzaWRlLgo+Cj5BbmQgaWYgd2UgZG8gY2hhbmdlIHRo
aXMsIHdlJ2QgcHJvYmFibHkgd2FudCB0byB1cGRhdGUKPnFnYS9xYXBpLXNjaGVtYS5qc29uIHRv
IHJlZmxlY3QgdGhlIGJlaGF2aW9yLiBJLmUuOgo+Cj4jIwo+IyBAZ3Vlc3QtZnNmcmVlemUtZnJl
ZXplOgo+Iwo+IyBTeW5jIGFuZCBmcmVlemUgYWxsIGZyZWV6YWJsZSwgbG9jYWwgZ3Vlc3QgZmls
ZXN5c3RlbXMuIElmIHRoaXMKPiMgY29tbWFuZCBzdWNjZWVkZWQsIHlvdSBtYXkgY2FsbCBAZ3Vl
c3QtZnNmcmVlemUtdGhhdyBsYXRlciB0bwo+IyB1bmZyZWV6ZS4KPi4uLgo+IyBSZXR1cm5zOiBO
dW1iZXIgb2YgZmlsZSBzeXN0ZW1zIGN1cnJlbnRseSBmcm96ZW4uIE9uIGVycm9yLCBhbGwgZmls
ZXN5c3RlbXMKPi0jIHdpbGwgYmUgdGhhd2VkLgo+KyMgd2lsbCBiZSB0aGF3ZWQuIElmIG5vIGZp
bGVzeXN0ZW1zIGFyZSBmcm96ZW4gYXMgYSByZXN1bHQgb2YgdGhpcyBjYWxsLAo+KyMgdGhlbiBA
Z3Vlc3QtZnNmcmVlemUtc3RhdHVzIHdpbGwgcmVtYWluICJ0aGF3ZWQiIGFuZCBjYWxsaW5nCj4r
IyBAZ3Vlc3QtZnNmcmVlemUtdGhhdyBpcyBub3QgbmVjZXNzYXJ5Lgo+CgpUaGFua3MgZm9yIHRo
ZSByZXZpZXcuCldpbGwgYmUgZml4ZWQgaW4gdjIuCgpSZWdhcmRzLAotIENoZW4K
