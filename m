Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED441C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08C520724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08C520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGt7U-000578-Vt
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGt6p-0004hk-8A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGt6n-0002mW-JG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:37:22 -0400
Resent-Date: Tue, 24 Mar 2020 19:37:22 -0400
Resent-Message-Id: <E1jGt6n-0002mW-JG@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGt6n-0002lK-BZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:37:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585093017; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nnbfZt217CLq9KHKuIaO6pfFRan0XaQAohQxL+iQLydKOt2J7MZocpZ1pqJx4+KWTDPL/6wG5DHodn1LVAJDR9OShY4VcII+6sZwMCqTFY2bGu021RA75h3q3ERvkhSEk1TS/iYI8vIMeLVE0nsmb86joRIwRs1eFOZe+gxY228=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585093017;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WMab4izxf6+APe71fIOZ20vSwDIHsuZrFtLh6EViUMU=; 
 b=PI1X6MHpC6CtwQbJtHNs/f6ONfKMHHSYH+2k8jhX/ekz67ElgIGGCCXU7xcvQwrF88phC2DUGD8Ru4oDgxj5NDnzo0A9M8X2QrrxKzTZFbq9VhqO8oEU5Ydksr5YHDe3dNu6lWHa+mW8crOzxBOtB2f15kl7rPqMmVqppsv9Piw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585093015079202.71461810576113;
 Tue, 24 Mar 2020 16:36:55 -0700 (PDT)
In-Reply-To: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 00/16] Add migration support for VFIO devices 
Message-ID: <158509301175.14921.3196817066929460330@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwankhede@nvidia.com
Date: Tue, 24 Mar 2020 16:36:55 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, zhi.a.wang@intel.com,
 jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg1MDg0MTU0LTI5NDYxLTEt
Z2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1j
ZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcg
U0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIHg4Nl82NC1zb2Z0bW11L2h3L3ZmaW8vcGNpLXF1aXJrcy5vCiAgQ0MgICAgICBhYXJjaDY0
LXNvZnRtbXUvaHcvaW50Yy9leHlub3M0MjEwX2NvbWJpbmVyLm8KL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L3ZmaW8vY29tbW9uLmM6IEluIGZ1bmN0aW9uICd2ZmlvX2xpc3Rlcm5lcl9sb2dfc3luYyc6
Ci90bXAvcWVtdS10ZXN0L3NyYy9ody92ZmlvL2NvbW1vbi5jOjk0NTo2NjogZXJyb3I6ICdnaW9t
bXUnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1t
YXliZS11bmluaXRpYWxpemVkXQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbW9yeV9y
ZWdpb25faW9tbXVfZ2V0X2FkZHJlc3NfbGltaXQoZ2lvbW11LT5pb21tdSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvdmZpby9jb21tb24uYzo5MjM6MjE6IG5vdGU6ICdnaW9tbXUn
IHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgVkZJT0d1ZXN0SU9NTVUgKmdpb21tdTsKICAgICAgICAg
ICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogW2h3L3ZmaW8vY29tbW9uLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9p
bnRjL29tYXBfaW50Yy5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvaW50Yy9iY20yODM1
X2ljLm8KLS0tCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvdmZpby9hbWQteGdiZS5vCiAg
Q0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvdmlydGlvL3ZpcnRpby5vCiAgQ0MgICAgICBhYXJj
aDY0LXNvZnRtbXUvaHcvdmlydGlvL3Zob3N0Lm8KbWFrZTogKioqIFt4ODZfNjQtc29mdG1tdS9h
bGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBD
QyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5vCiAgQ0MgICAg
ICBhYXJjaDY0LXNvZnRtbXUvaHcvdmlydGlvL3Zob3N0LXVzZXIubwotLS0KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS9ody92aXJ0aW8vdmlydGlvLWlvbW11Lm8KICBDQyAgICAgIGFhcmNoNjQt
c29mdG1tdS9ody92aXJ0aW8vdmhvc3QtdnNvY2subwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvdmZp
by9jb21tb24uYzogSW4gZnVuY3Rpb24gJ3ZmaW9fbGlzdGVybmVyX2xvZ19zeW5jJzoKL3RtcC9x
ZW11LXRlc3Qvc3JjL2h3L3ZmaW8vY29tbW9uLmM6OTQ1OjY2OiBlcnJvcjogJ2dpb21tdScgbWF5
IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVu
aW5pdGlhbGl6ZWRdCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9p
b21tdV9nZXRfYWRkcmVzc19saW1pdChnaW9tbXUtPmlvbW11LAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVt
dS10ZXN0L3NyYy9ody92ZmlvL2NvbW1vbi5jOjkyMzoyMTogbm90ZTogJ2dpb21tdScgd2FzIGRl
Y2xhcmVkIGhlcmUKICAgICBWRklPR3Vlc3RJT01NVSAqZ2lvbW11OwogICAgICAgICAgICAgICAg
ICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06
ICoqKiBbaHcvdmZpby9jb21tb24ub10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3Ig
dW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW2FhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9y
IDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9j
a2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigp
KQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nl
c3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywg
J3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzliMDFiY2M3ZmMwNGUy
ZDhmNWU3NGJmNDYwZjBkN2EnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNj
b21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhU
UkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVC
VUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2Fj
aGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIv
dG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1sbmUzMXBu
Ny9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTI0LTE5LjMzLjQ2LjE0MTQ5Oi92YXIvdG1wL3FlbXU6
eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljaydd
JyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1jOWIwMWJjYzdmYzA0ZTJkOGY1ZTc0YmY0NjBmMGQ3YQpt
YWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rv
cnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1sbmUzMXBuNy9zcmMnCm1ha2U6ICoqKiBb
ZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgM201LjYzNHMK
dXNlciAgICAwbTguMzM1cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMTU4NTA4NDE1NC0yOTQ2MS0xLWdpdC1zZW5kLWVtYWlsLWt3YW5raGVk
ZUBudmlkaWEuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

